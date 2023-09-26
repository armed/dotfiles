(ns aliases 
  (:require
   [babashka.fs :as fs]
   [clojure.java.io :as io]
   [clojure.string :as string]))

(def aliases-file ".repl_aliases")
(def lsp-config-path ".lsp/config.edn")

(defn load-aliases!
  []
  (when (fs/exists? aliases-file)
    (some-> aliases-file (slurp) (string/split-lines) (set))))

(defn update-lsp-config!
  [aliases]
  (let [lsp-config (fs/file lsp-config-path)]
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
