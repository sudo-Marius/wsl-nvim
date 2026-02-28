-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:codedark_term256 = 1")
vim.cmd("let g:fzf_vim = {}")
vim.cmd("let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']")
vim.cmd("nmap <F8> :TagbarToggle<CR>")
vim.cmd("filetype plugin indent on")
vim.cmd([[command! Ex Explore]])
--vim.cmd[[colorscheme darkplus]]

local options ={
    --numbers
    relativenumber = true,
    number = true,
    signcolumn = "yes",
    --tabs & Indentations
    tabstop = 2,
    shiftwidth = 2,
    showtabline = 2,
    expandtab = true,
    autoindent = true,
    wrap = false,
    --color
    termguicolors = true,
    --search settings
    ignorecase = true,
    smartcase = true,
    cursorline = true,
    --backspace
    backspace = "indent,eol,start",
    --split windows
    splitright = true,
    splitbelow = true,
}

vim.opt.shortmess:append { c = true }

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.clipboard:append("unnamedplus")

-- leader keys (not strictly an option but convenient)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--local opt = vim.opt

--opt.relativenumber = true
--opt.number = true

--tabs & Indentations
--opt.tabstop = 2
--opt.shiftwidth = 2
--opt.expandtab = true
--opt.autoindent = true

--opt.wrap = false

--search settings
--opt.ignorecase = true
--opt.smartcase = true

--opt.cursorline = true

--backspace
--opt.backspace = "indent,eol,start"

--clipboard
--opt.clipboard:append("unnamedplus")

--split windows
--opt.splitright = true
--opt.splitbelow = true