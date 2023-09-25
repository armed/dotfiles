#!/usr/bin/env bb
(ns repl
  (:require
   [babashka.fs :as fs]
   [babashka.process :as bp]
   [clojure.edn :as edn]
   [clojure.java.io :as io]
   [clojure.string :as string]
   [clojure.tools.build.api :as b]))

(defn dirname []
  (let [current-path (fs/cwd)
        parent-path  (fs/parent current-path)]
    (str (fs/relativize parent-path current-path))))

(def lsp-config-path ".lsp/config.edn")
(def aliases-file ".repl_aliases")

(def default-aliases #{"cider" "dev" "portal" "scope-capture"})

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
  (bp/shell "rm -f pom.xml")
  (bp/shell "rm -rf .cpcache"))

(defn basis->mvn-deps
  [basis]
  (let [libs (filter (fn [[_ props]]
                       (= :mvn (:deps/manifest props)))
                     (-> basis :libs))]
    (map (fn [[lib props]]
           (let [group-id (or (namespace lib)
                              (name lib))
                 artifact-id (name lib)
                 version (:mvn/version props)]
             (str "    <dependency>\n"
                  "      <groupId>" group-id "</groupId>\n"
                  "      <artifactId>" artifact-id "</artifactId>\n"
                  "      <version>" version "</version>\n"
                  "    </dependency>")))
         libs)))

(defn write-pom!
  [aliases]
  (let [basis (b/create-basis {:project "deps.edn"
                               :aliases aliases})
        lib-name (.getName (fs/file (fs/cwd)))]
    (with-out-str (b/write-pom {:basis basis
                                :lib (-> (str "armed/" lib-name)
                                         (symbol))
                                :target "."
                                :version "0.0.0"}))
    (let [pom-data (-> (slurp "pom.xml") (string/split-lines))
          pre-deps (take-while (fn [s]
                                 (-> s string/trim (not= "<dependencies>")))
                               pom-data)
          post-deps (drop 1 (drop-while (fn [s]
                                          (-> s string/trim (not= "</dependencies>")))
                                        pom-data))
          deps (basis->mvn-deps basis)]
      (spit "pom.xml" (string/join "\n" (concat pre-deps
                                                ["  <dependencies>"]
                                                deps
                                                ["  </dependencies>"]
                                                post-deps))))))

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
      (write-pom! selected-aliases)
      (println cmd)
      (bp/shell (str "echo \"\033]0;" (dirname) "[repl]\007\""))
      (bp/shell cmd))
    (catch Exception e
      (let [data (ex-data e)]
        (when-not (= 130 (:exit data))
          (print (ex-message e))))))
  (println "No local deps.edn found, bye"))

