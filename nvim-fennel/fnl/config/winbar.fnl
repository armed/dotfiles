(module config.plugin.winbar
  {autoload {winbar winbar
             util config.util
             cp catppuccin.palettes
             wdi nvim-web-devicons
             navic nvim-navic
             icons config.icons
             nvim aniseed.nvim}})

(local mocha-colors (cp.get_palette :mocha))

(nvim.set_hl 0 :WinBarSeparator {:fg mocha-colors.surface0})
(nvim.set_hl 0 :WinBarFilename {:fg mocha-colors.text 
                                :bg mocha-colors.surface0})
(nvim.set_hl 0 :WinBarContext {:fg mocha-colors.text 
                               :bg mocha-colors.surface0})

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

(fn floating? []
  (let [cfg (vim.api.nvim_win_get_config 0)]
    (not= "" cfg.relative)))

(fn excludes? []
  (or (vim.tbl_contains winbar_filetype_exclude vim.bo.filetype)
      (conjure-log?)
      (floating?)))

(defn get_modified []
  (if (util.get-buf-option :mod)
    (.. "%#WinBarContext#" 
        icons.config.ui.Circle)
    ""))

(defn get_location []
  (.. "%#WinBarContext#"
      (let [ft vim.bo.filetype
            icon (or (wdi.get_icon_by_filetype ft) "")]
        (.. icon " " 
            (if (and navic (navic.is_available))
              (.. (vim.fn.expand "%:t")
                  " : "
                  (navic.get_location))
              (vim.fn.expand "%:~:.")))) 
      "%*"))

(fn get-winbar []
  (.. "%#WinBarSeparator#"
      "%#WinBarContext# "
      "%{%v:lua.require'config.winbar'.get_modified()%}"
      "%{%v:lua.require'config.winbar'.get_location()%}"
      "%#WinBarSeparator#"
      ""
      "%*"))

(fn set-local-winbar []
  (set vim.opt_local.winbar (when (not (excludes?))
                              (get-winbar))))

(nvim.create_autocmd
  "BufEnter,WinEnter"
  {:pattern "*"
   :callback set-local-winbar})
