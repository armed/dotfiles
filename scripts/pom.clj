(ns pom
  (:require
   aliases
   [babashka.fs :as fs]
   [clojure.string :as string]
   [clojure.tools.build.api :as b]))

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

