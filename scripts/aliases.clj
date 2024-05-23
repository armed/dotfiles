(ns aliases 
  (:require
   [babashka.fs :as fs]
   [clojure.string :as string]))

(def aliases-file ".repl_aliases")

(defn load-aliases!
  []
  (when (fs/exists? aliases-file)
    (some-> aliases-file (slurp) (string/split-lines) (set))))

(defn save-aliases!
  [aliases]
  (if (seq aliases)
    (spit aliases-file (string/join "\n" (map name aliases)))
    (when (fs/exists? aliases-file)
      (fs/delete aliases-file))))
