(module config.plugin.lualine
  {autoload {lualine lualine
             navic nvim-navic
             core aniseed.core
             cp catppuccin.palettes}})

(local palette (cp.get_palette :mocha))
(local theme (require :lualine.themes.catppuccin))
(set theme.normal.c.bg palette.surface0)

(defn get_lsp_client_names 
  []
  (let [clients (icollect [_ client (ipairs (vim.lsp.buf_get_clients))]
                  client.name)]
    (.. "[" (table.concat clients ",") "]")))

(fn show-macro-recording []
  (let [recording-register (vim.fn.reg_recording)]
    (if (= recording-register "")
      ""
      (.. "Recording @" recording-register))))

(local config {:options {:icons_enabled true
                         :globalstatus true
                         :theme theme
                         ;; :component_sep arators {:left "" :right ""}
                         ;; :section_separators {:left "" :right ""}
                         :component_separators {:left "" :right ""}
                         :section_separators {:left "" :right ""}
                         :disabled_filetypes {}}
               :sections {:lualine_a [:mode]
                          :lualine_b [:diagnostics :diff {1 :macro-recording
                                                          :fmt show-macro-recording}]
                          :lualine_c [{1 :filename :path 1}]
                          :lualine_x [["require'config.plugin.lualine'.get_lsp_client_names()"] :progress]
                          :lualine_y [:filetype]
                          :lualine_z [:branch]}
               :tabline {}
               :extensions {}})

(fn ins-left [component]
  (table.insert config.sections.lualine_c component))
(fn ins-right [component]
  (table.insert config.sections.lualine_x component))

(lualine.setup config)

(vim.api.nvim_create_autocmd
  :RecordingEnter
  {:callback (fn [] (lualine.refresh {:place [:statusline]}))})
(vim.api.nvim_create_autocmd
  :RecordingLeave
  {:callback (fn []
               (local timer (vim.loop.new_timer))
               (timer:start 
                 30
                 0
                 (vim.schedule_wrap
                   (fn [] (lualine.refresh {:place [:statusline]})))))})
