require('mason').setup()
require('mason-lspconfig').setup()

---
-- Global Config
---

local lsp_on_attach = require("zu.lsp.handlers").on_attach
local lsp_capabilities = require("zu.lsp.handlers").capabilities
local lsp_flags = {
  debounce_text_changes = 150,
}

local lsp_defaults = {
  flags = lsp_flags,
  capabilities = lsp_capabilities,
  on_attach = lsp_on_attach,
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

---
-- LSP Servers
---

local sumneko_lua_opts = require("zu.lsp.settings.sumneko_lua")
lspconfig.sumneko_lua.setup(sumneko_lua_opts)

local jsonls_opts = require("zu.lsp.settings.jsonls")
lspconfig.jsonls.setup(jsonls_opts)

local pyright_opts = require("zu.lsp.settings.pyright")
lspconfig.pyright.setup(pyright_opts)

lspconfig.taplo.setup {}
lspconfig.solidity.setup {}
lspconfig.tsserver.setup {}
lspconfig.move_analyzer.setup {}

local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status_ok then
  return
end
local rust_opts = require("zu.lsp.settings.rust_analyzer")
rust_tools.setup(rust_opts)

---
-- Extras
---

require("zu.lsp.handlers").setup()
require "zu.lsp.null-ls"
