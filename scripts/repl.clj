#!/usr/bin/env bb

(ns repl
  (:require
   [babashka.fs :as fs]
   [babashka.process :as bp]
   [clojure.edn :as edn]
   [clojure.java.io :as io]
   [clojure.string :as string]))

(defn dirname []
  (let [current-path (fs/cwd)
        parent-path  (fs/parent current-path)]
    (str (fs/relativize parent-path current-path))))

(def lsp-config-path ".lsp/config.edn")
(def aliases-file ".repl_aliases")

(def default-aliases #{"cider" "dev" "portal"})

(def project-aliases (when-let [deps (some-> "deps.edn"
                                             (slurp)
                                             (edn/read-string))]
                       (if-let [aliases (:aliases deps)]
                         (->> aliases
                              (keys)
                              (mapv name)
                              (into default-aliases))
                         default-aliases)))

(defn load-aliases!
  []
  (when (fs/exists? aliases-file)
    (some-> aliases-file (slurp) (string/split-lines) (set))))

(defn update-lsp-config!
  [aliases]
  (let [lsp-config (fs/file ".lsp/config.edn")]
    (io/make-parents lsp-config)
    (spit lsp-config (str {:source-aliases (vec aliases)}))))

(defn save-aliases!
  [aliases]
  (if (seq aliases)
    (do
      (spit aliases-file (string/join "\n" (map name aliases)))
      (update-lsp-config! aliases))
    (when (fs/exists? aliases-file)
      (fs/delete aliases-file))))

(defn ensure-source-aliases
  [config]
  (if-not (seq (:source-aliases config))
    (assoc config :source-aliases #{:dev :test})
    config))

(defn resolve-lsp-config
  [f]
  (ensure-source-aliases
   (some-> (fs/exists? f)
           (slurp)
           (edn/read-string))))

(defn reconfigure-lsp!
  [aliases]
  (if (seq aliases)
    (let [f (fs/file lsp-config-path)
          config (-> (resolve-lsp-config f)
                     (update :source-aliases conj aliases))]
      (io/make-parents f)
      (spit f (str config)))))

(defn clean!
  []
  (bp/shell "rm -rf .cpcache"))

(if (seq project-aliases)
  (try
    (let [_ (println "Select aliases to run...")
          saved-aliases (load-aliases!)

          selected-flag (str "--selected="
                             (string/join
                              ","
                              (or saved-aliases default-aliases))
                             " ")

          selected-aliases (->> (bp/shell
                                 {:out :string}
                                 (str "gum choose --no-limit "
                                      selected-flag
                                      (string/join " " project-aliases)))
                                :out
                                (string/split-lines)
                                (mapv keyword))
          cmd (str "clojure -M" (string/join selected-aliases))]
      (save-aliases! selected-aliases)
      (clean!)
      (println cmd)
      (bp/shell (str "echo \"\033]0;" (dirname) "[repl]\007\""))
      (bp/shell cmd))
    (catch Exception e
      (let [data (ex-data e)]
        (when-not (= 130 (:exit data))
          e))))
  (println "No local deps.edn found, bye"))

