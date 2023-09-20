#!/usr/bin/env bb
(ns jars
  (:require
   [babashka.fs :as fs]
   [clojure.edn :as edn]
   [clojure.string :as string]
   [clojure.walk :as walk]))

(def m2-path (first *command-line-args*))

(defn gather-deps [deps]
  (let [jar-paths (transient [])]
    (walk/postwalk
     (fn [form]
       (when (and (map-entry? form)
                  (contains? #{:deps :extra-deps :replace-deps}
                             (key form)))
         (let [deps-map (val form)
               paths (->> deps-map
                          (mapv (fn [[coord version-map]]
                                  (when-let [version (:mvn/version version-map)]
                                    (let [coord (str coord)
                                          [group artifact] (string/split coord #"/")
                                          artifact (or artifact group)]
                                      (str m2-path
                                           "/repository/"
                                           (string/replace group #"\." "/")
                                           "/"
                                           artifact
                                           "/"
                                           version
                                           "/"
                                           artifact
                                           "-"
                                           version
                                           ".jar")))))
                          (remove nil?)
                          (filter fs/exists?))]
           (doseq [p paths]
             (conj! jar-paths p))))
       form)
     deps)
    (persistent! jar-paths)))


(print (string/join "\n" (gather-deps (-> *command-line-args*
                                          (second)
                                          (slurp)
                                          (edn/read-string)))))



