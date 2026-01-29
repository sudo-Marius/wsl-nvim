-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic sanity
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- Keymaps (your layout)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal
map("n", "a", "h", opts)
map("n", "d", "l", opts)
map("n", "A", "0", opts)
map("n", "D", "$", opts)
map("n", "w", "^", opts)
map("n", "s", "gm", opts)
map("n", "k", "j", opts)
map("n", "l", "k", opts)
map("n", "K", "<C-d>", opts)
map("n", "L", "<C-u>", opts)
map("n", "J", "<C-f>", opts)
map("n", "+", "<C-b>", opts)

-- Visual
map("v", "a", "h", opts)
map("v", "d", "l", opts)
map("v", "A", "0", opts)
map("v", "D", "$", opts)
map("v", "w", "^", opts)
map("v", "s", "gm", opts)
map("v", "k", "j", opts)
map("v", "l", "k", opts)

-- Splits
map("n", "<leader>v", "<C-w>v", opts)
map("n", "<leader>c", "<C-w>s", opts)
map("n", "<leader>q", "<C-w>c", opts)
map("n", "<leader>a", "<C-w>h", opts)
map("n", "<leader>d", "<C-w>l", opts)
map("n", "<leader>w", "<C-w>k", opts)
map("n", "<leader>s", "<C-w>j", opts)

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
},
  {
  "Mofiqul/vscode.nvim",
  priority = 1000, -- load before other UI stuff
  config = function()
    vim.opt.termguicolors = true
    vim.opt.background = "dark"

    require("vscode").setup({})
    require("vscode").load()
  end,
},
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
      window = {
        width = 32,
        mappings = {
          ["<space>"] = "toggle_node",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    })

    -- Toggle with Space + e
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, noremap = true })
  end,
},
})

local builtin = require("telescope.builtin")

-- Files (like Ctrl+P)
vim.keymap.set("n", "<leader>p", builtin.find_files, { silent = true })
vim.keymap.set("n", "<leader>f", builtin.live_grep, { silent = true })
vim.keymap.set("n", "<leader>b", builtin.buffers, { silent = true })
vim.keymap.set("n", "<leader>r", builtin.oldfiles, { silent = true })

-- LSP (Neovim 0.11+ native)
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "lua_ls" },
})

vim.lsp.config("ts_ls", {})

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config("jdtls", {
  cmd = {
    mason_bin .. "/jdtls",
    "--java-executable",
    "/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
  },

  settings = {
    ["java.imports.gradle.wrapper.checksums"] = {},
  },
})

vim.lsp.config("yamlls", {})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.enable({ "ts_ls", "jdtls", "yamlls", "lua_ls" })