require "nvchad.options"

local o = vim.opt

-- Leader is already Space in NvChad, but you used "," -- decide if you want to change it
-- vim.g.mapleader = ","  -- uncomment to restore your old leader

-- Editing behavior
o.wrap = false          -- don't wrap lines (vimrc: nowrap)
o.linebreak = true      -- wrap at convenient points if wrap is on
o.scrolloff = 2         -- keep lines visible at top/bottom
o.timeoutlen = 500      -- faster chord timeout (matches your vimrc)
o.foldlevelstart = 99   -- open all folds on file open
o.conceallevel = 0      -- disable conceal globally
o.spelllang = "en_us"
o.clipboard = "unnamed" -- yank to system clipboard

-- Searching
o.ignorecase = true
o.smartcase = true

-- Indentation defaults (4 spaces, like your vimrc)
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
o.expandtab = true
o.shiftround = true

-- Diff
o.diffopt:append("vertical")

-- Backup
o.backup = true
o.backupdir = vim.fn.expand("~/.vimtmp")
o.backupext = ".vimbackup"
o.swapfile = false
vim.fn.mkdir(vim.fn.expand("~/.vimtmp"), "p")
