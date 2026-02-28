local ok_mason, mason = pcall(require, "mason")
local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")

if not ok_lspconfig then
  return
end

if ok_mason then
  mason.setup()
end

if ok_mason_lsp then
  mason_lsp.setup({
    ensure_installed = { "gopls", "ts_ls", "lua_ls", "yamlls", "jdtls" },
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp and cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

local on_attach = function(client, bufnr)
  local buf_set_option = vim.api.nvim_buf_set_option
  buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- map hover key locally when LSP attaches
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap=true, silent=true })
end

local default_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- per-server custom settings
local server_opts = {
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  },
  jdtls = {
    cmd = {
      mason_bin .. "/jdtls",
      "--java-executable",
      "/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
    },
    settings = {
      ["java.imports.gradle.wrapper.checksums"] = {},
    },
  },
}

if ok_mason_lsp then
  mason_lsp.setup_handlers({
    function(server_name)
      if lspconfig[server_name] then
        local opts = vim.tbl_extend("force", {}, default_opts)
        if server_opts[server_name] then
          opts = vim.tbl_extend("force", opts, server_opts[server_name])
        end
        lspconfig[server_name].setup(opts)
      end
    end,
  })
else
  if lspconfig["gopls"] then
    lspconfig["gopls"].setup(default_opts)
  end
end

-- ensure lsp is enabled for our servers
vim.lsp.enable({ "ts_ls", "jdtls", "yamlls", "lua_ls", "gopls" })
