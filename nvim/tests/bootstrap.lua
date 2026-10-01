-- Run these checks with -u NONE: never start real language servers or write user files.
vim.opt.rtp:prepend(vim.fn.getcwd())
