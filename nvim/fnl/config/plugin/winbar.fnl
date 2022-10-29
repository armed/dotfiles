(module config.plugin.winbar
  {autoload {winbar winbar
             util config.util
             navic nvim-navic
             icons config.icons
             nvim aniseed.nvim}})

(local colors {:darker_black "#272f35"
               :black "#2b3339"
               :black2 "#323a40"
               :folder_bg "#538AD2"})

(nvim.set_hl 0 :WinBarSeparator {:fg colors.folder_bg})
(nvim.set_hl 0 :WinBarFilename {:fg colors.black :bg colors.folder_bg})
(nvim.set_hl 0 :WinBarContext {:fg colors.black :bold true :bg colors.folder_bg})

(local winbar_filetype_exclude [:help
                                :startify
                                :dashboard
                                :packer
                                :neogitstatus
                                :NvimTree
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

(fn excludes? []
  (if (or (vim.tbl_contains winbar_filetype_exclude vim.bo.filetype)
          (conjure-log?))
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

(defn get_winbar []
  (if (not (excludes?))
    (.. "%#WinBarSeparator#"
        "%="
        ""
        "%*"
        (get-modified)
        (get-location)
        "%#WinBarSeparator#"
        ""
        "%*")
    ""))

