local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
--local util = require "lspconfig/util"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd" }

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact","javascriptreact","javascript.jsx", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}
lspconfig.marksman.setup{
  on_attach=on_attach,
  filetypes= {"markdown", "markdown.mdx", "markdown.md"},
  cmd={ "marksman", "server" },
}
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- filetypes = {" astro, astro-markdown, html, html-eex, mdx, css, less, postcss, sass, scss, javascript, javascriptreact, typescript, typescriptreact, svelte"}

}
lspconfig.astro.setup {
  init_options = {
    configuration = {},
    on_attach = on_attach,
    capabilities = capabilities,
    typescript = { serverPath = vim.fs.normalize '~/.nvm/versions/node/v19.9.0/lib/node_modules/typescript/lib/tsserverlibrary.js', },

  },
}

lspconfig.golangci_lint_ls.setup{
  on_attach = on_attach,
  cmd={"golangci-lint-langserver"},
  filetypes = { "go", "gomod" },
  init_options ={
  command = { "golangci-lint", "run", "--out-format", "json" }
}
}

lspconfig.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
      flags = {
         debounce_text_changes = 150,
      },
      settings = {
         gopls = {
            gofumpt = true,
            experimentalPostfixCompletions = true,
            staticcheck = true,
            usePlaceholders = true,
         },
      },
   }

-- if not lspconfig.golangcilsp then
--       local configs = require "lspconfig/configs"
--
--       configs.golangcilsp = {
--          default_config = {
--             cmd = { "golangci-lint-langserver" },
--             root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
--             init_options = {
--                command = { "golangci-lint", "run", "--out-format", "json" },
--             },
--          },
--       }
--    end

-- lspconfig.golangcilsp.setup {
      -- filetypes = { "go" },
   -- }


for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
