(module config.plugin.packer
  {autoload {nvim aniseed.nvim
             packer packer}})

(packer.init {:snapshot_path (.. (os.getenv "HOME") "/.config/nvim/packer.nvim")})
