--local config = require("plugins.configs.lspconfig")
--local on_attach = config.on_attach
--local capabilities = config.capabilities
--
--local lspconfig = require("lspconfig")
--
--local server = {
--"tailwindcss",
--  "tsserver",
--  "eslint"
--}
--
--
--
--local function organize_imports()
--  local params = {
--    command = "_typescript.organizeImports",
--    arguments = {vim.api.nvim_buf_get_name(0)},
--  }
--  vim.lsp.buf.execute_command(params)
--end
--
--lspconfig.tsserver.setup {
--  on_attach = on_attach,
--  capabilities = capabilities,
--  init_options = {
--    preferences = {
--      disableSuggestions = true,
--    }
--  },
--  commands = {
--    OrganizeImports = {
--      organize_imports,
--      description = "Organize Imports",
--    }
--  }
--}
--
--
--for _, lsp in ipairs(server) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--
--  }
--end
--


local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {"tsserver", "tailwindcss", "eslint", "cssls", "html", "jsonls", "lua"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
