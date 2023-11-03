#!/usr/bin/env bb
(ns repl
  (:require
   aliases
   pom
   [babashka.fs :as fs]
   [babashka.process :as bp]
   [clojure.edn :as edn]
   [clojure.string :as string]))

(defn dirname []
  (let [current-path (fs/cwd)
        parent-path  (fs/parent current-path)]
    (str (fs/relativize parent-path current-path))))

(def default-aliases #{"cider" "dev" "portal" "scope-capture" "storm"})

(def project-aliases (when-let [deps (some-> "deps.edn"
                                             (slurp)
                                             (edn/read-string))]
                       (if-let [aliases (:aliases deps)]
                         (->> aliases
                              (keys)
                              (mapv name)
                              (into default-aliases))
                         default-aliases)))

(defn ensure-source-aliases
  [config]
  (if-not (seq (:source-aliases config))
    (assoc config :source-aliases #{:dev :test})
    config))

(defn clean!
  []
  (bp/shell "rm -f pom.xml")
  (bp/shell "rm -rf .cpcache"))

(if (seq project-aliases)
  (try
    (let [_ (println "Select aliases to run...")
          saved-aliases (aliases/load-aliases!)

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
      (aliases/save-aliases! selected-aliases)
      (clean!)
      (pom/write-pom! selected-aliases)
      (println cmd)
      (bp/shell (str "echo \"\033]0;" (dirname) "[repl]\007\""))
      (bp/shell cmd))
    (catch Exception e
      (let [data (ex-data e)]
        (when-not (= 130 (:exit data))
          (print (ex-message e))))))
  (println "No local deps.edn found, bye"))

