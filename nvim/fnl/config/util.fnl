(module config.util
  {autoload {core aniseed.core
             packer packer
             nvim aniseed.nvim}})

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(def config-path (nvim.fn.stdpath "config"))

(defn set-global-option [key value]
  "Sets a nvim global options"
  (core.assoc nvim.o key value))

(defn set-global-variable [key value]
  "Sets a nvim global variables"
  (core.assoc nvim.g key value))

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn use [pkgs]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (packer.startup
      (fn [use]
        (core.run! 
          (fn [[name opts]]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (core.assoc opts 1 name)))
          (core.kv-pairs pkgs))))
  nil)

(defn packer-snapshot [?label]
  (let [name (.. (or ?label (os.time)) :.json)]
    (packer.snapshot name)
    name))

(defn custom-packer-snapshot []
  (let [sn (nvim.fn.input "Snapshot label: ")]
    (when (> (length sn) 0)
      (print "Snapshot created: " (packer-snapshot sn)))))

