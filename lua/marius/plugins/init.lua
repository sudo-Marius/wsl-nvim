return {
    -- syntax/treesitter support (Go + others)
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "go", "lua", "javascript", "yaml" },
          highlight = { enable = true },
          indent = { enable = true },
        }
      end,
    },

    -- miscellaneous plugins
    "christoomey/vim-tmux-navigator",
    "nvimdev/dashboard-nvim",
    "tomasiser/vim-code-dark",
    "preservim/tagbar",
    "junegunn/fzf.vim",
    "vim-airline/vim-airline",

    -- theme plugins
    {
        "gmr458/vscode_modern_theme.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("vscode_modern").setup({
                cursorline = true,
                transparent_background = false,
                nvim_tree_darker = true,
            })
            vim.cmd.colorscheme("vscode_modern")
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"

            require("vscode").setup({})
            require("vscode").load()
        end,
    },

    -- LSP and tooling
    {
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- file explorer
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
                    hijack_netrw_behavior = "disabled",
                },
                window = {
                    width = 32,
                    mappings = {
                        ["<space>"] = "toggle_node",
                        ["o"] = "open",
                        ["h"] = "close_node",
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", function()
                require("neo-tree.command").execute({
                    toggle = true,
                    reveal = true,
                })
            end, { silent = true })
        end,
    },

    -- completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),        -- trigger menu manually
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- enter to accept
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                }),
            })
        end,
    },
}


