(ns user
  (:require [clojure.edn :as edn]
            [clj-commons.ansi :as ansi]
            [clj-commons.pretty.repl :as pretty.repl]))

(defonce local-dev* (atom nil))

(alter-var-root #'*warn-on-reflection* (constantly true))
(alter-var-root #'ansi/*color-enabled* (constantly false))

(pretty.repl/install-pretty-exceptions)

(defn load-alias []
  (or @local-dev*
      (some->> (slurp "deps.local.edn")
               (edn/read-string)
               :aliases
               :local-dev
               (reset! local-dev*))))

(defn reset-app! []
  (if-let [sym (some-> (load-alias) :reset-fn)]
    (let [f (requiring-resolve sym)]
      (println f)
      (f))
    (println "No reset-fn FQN is specified in local-dev alias")))

(defn stop-app! []
  (if-let [sym (some-> (load-alias) :stop-fn)]
    (let [f (requiring-resolve sym)]
      (println f)
      (f))
    (println "No stop-fn FQN is specified in local-dev alias")))

(print (str "\033[38;2;255;165;0m"
            "Local dev init complete"
            "\033[m\n"))

