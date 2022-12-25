(module config.plugin.alpha
  {autoload {alpha alpha
             dashboard alpha.themes.dashboard}})

(set dashboard.section.header.val 
     ["                                                     "
      "                                                     "
      "                                                     "
      "                                                     "
      "                                                     "
      "                                                     "
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ "
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ "
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ "
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ "
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ "
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ "
      "                                                     "])

(set dashboard.section.buttons.val 
     [(dashboard.button "SPC f f" "  > Find file"  ":Telescope find_files<CR>")
      (dashboard.button "SPC f r" "  > Recent"     ":Telescope oldfiles<CR>")
      (dashboard.button "SPC S f" "  > Workspaces" ":Telescope workspaces<CR>")
      (dashboard.button "q" "  > Quit NVIM" ":qa<CR>")])

(alpha.setup dashboard.opts)

(vim.cmd "autocmd FileType alpha setlocal nofoldenable")
