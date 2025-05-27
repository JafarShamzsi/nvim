vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  extends = "⟩",
  precedes = "⟨",
  trail = "·",
  nbsp = "␣",
  eol = "↲",
}

-- Editing Options
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Search Options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Performance Options
vim.opt.lazyredraw = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- Clipboard Options
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- Window Options
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = true

-- Backup Options
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Completion Options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest", "full" }
vim.opt.wildmenu = true
