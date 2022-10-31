(module config.plugin.winbar
  {autoload {winbar winbar
             util config.util
             navic nvim-navic
             cp catppuccin.palettes
             icons config.icons
             nvim aniseed.nvim}})

(local mocha-colors (cp.get_palette :mocha))

(nvim.set_hl 0 :WinBarSeparator {:fg mocha-colors.blue})
(nvim.set_hl 0 :WinBarFilename {:fg mocha-colors.base 
                                :bg mocha-colors.blue})
(nvim.set_hl 0 :WinBarContext {:fg mocha-colors.base 
                               :bold true 
                               :bg mocha-colors.blue})

(local winbar_filetype_exclude [:help
                                :startify
                                :dashboard
                                :packer
                                :neogitstatus
                                :NvimTree
                                :neo-tree
                                :Trouble
                                :alpha
                                :lir
                                :Outline
                                :spectre_panel
                                :toggleterm])

(fn conjure-log? []
  (let [fname (vim.fn.expand "%:t")
        pattern "^conjure%-log"]
    (not= nil (fname:find pattern))))

(fn relative? []
  (let [cfg (vim.api.nvim_win_get_config 0)]
    (not= "" cfg.relative)))

(fn excludes? []
  (if (or (vim.tbl_contains winbar_filetype_exclude vim.bo.filetype)
          (conjure-log?)
          (relative?))
    (do
      (set vim.opt_local.winbar nil)
      true)
    false))

(fn get-modified []
  (if (util.get-buf-option :mod)
    (.. "%#WinBarContext#" 
        icons.config.ui.Circle)
    ""))

(fn get-location []
  (.. "%#WinBarContext#"
      (vim.fn.expand "%:~:.") "%*"))	

(fn get-winbar []
  (.. "%#WinBarSeparator#"
      "%="
      ""
      "%*"
      (get-modified)
      (get-location)
      "%#WinBarSeparator#"
      ""
      "%*"))

(fn set-local-winbar []
  (when (not (excludes?))
    (set vim.opt_local.winbar (get-winbar))))

(nvim.create_autocmd
  "BufEnter,WinEnter"
  {:pattern "*"
   :callback set-local-winbar})
