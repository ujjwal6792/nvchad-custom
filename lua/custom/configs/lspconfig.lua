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
   	filetypes = {"aspnetcorerazor, astro, astro-markdown, blade, clojure, django-html, htmldjango, edge, eelixir, elixir, ejs, erb, eruby, gohtml, gohtmltmpl, haml, handlebars, hbs, html, html-eex, heex, jade, leaf, liquid, mdx, mustache, njk, nunjucks, php, razor, slim, twig, css, less, postcss, sass, scss, stylus, sugarss, javascript, javascriptreact, reason, rescript, typescript, typescriptreact, vue, svelte"}

}
lspconfig.astro.setup {
  init_options = {
    configuration = {},
    on_attach = on_attach,
    capabilities = capabilities,
    typescript = { serverPath = vim.fs.normalize '~/.nvm/versions/node/v19.9.0/lib/node_modules/typescript/lib/tsserverlibrary.js', },

  },
}



for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
