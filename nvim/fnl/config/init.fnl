(module config.init)

(require :config.core)
(require :config.mapping)
(require :config.plugin)

;; optional module with local overrides
(pcall #(require :config.local))

