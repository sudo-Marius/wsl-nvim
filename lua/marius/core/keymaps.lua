-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local keymap = vim.keymap

--Movement key remapping
keymap.set("n", ";", "l")
keymap.set("n", "j", "h")
keymap.set("n", "k", "j")
keymap.set("n", "l", "k")
keymap.set("n", "-", "<S-a>")

--Search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--Insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

--Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- Split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- Split horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- Make split equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- Close :exitthe current split

-- make leader stuff available
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- clipboard mappings
map("n", "cp", [[+"y]], opts)
map("n", "cv", [[+"y]], opts)
map("v", "cp", [[+"y]], opts)
map("v", "cv", [[+"y]], opts)

-- copy/delete lines above the cursor with a count
map("n", "yu", function()
  local n = vim.v.count1
  local cur = vim.fn.line(".")
  local start = math.max(1, cur - n)
  local finish = cur - 1
  vim.cmd(string.format("%d,%dyank", start, finish))
end, { silent = true })

map("n", "du", function()
  local n = vim.v.count1
  local cur = vim.fn.line(".")
  local start = math.max(1, cur - n)
  local finish = cur - 1
  if finish < start then return end
  vim.cmd(string.format("%d,%dd", start, finish))
end, { silent = true })

-- toggle relative numbers
map("n", "<leader>n", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true })

-- telescope shortcuts (load only if telescope is available)
local ok_tel, builtin = pcall(require, "telescope.builtin")
if ok_tel then
  map("n", "<leader>p", builtin.find_files, { silent = true })
  map("n", "<leader>f", builtin.live_grep, { silent = true })
  map("n", "<leader>b", builtin.buffers, { silent = true })
  map("n", "<leader>r", builtin.oldfiles, { silent = true })
end

-- lsp hover mapping (also added in on_attach for safety)
map("n", "<leader>h", vim.lsp.buf.hover, { silent = true })
