local status, null_ls = pcall(require, "null-ls")
local null_ls_utils = require "null-ls.utils"
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
if not status then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  }
end

null_ls.setup {
  sources = {
    formatting.prettierd,
    formatting.stylua, -- lua formatter
    formatting.gofumpt,
    diagnostics.eslint_d.with { -- js/ts linter
      diagnostics_format = "[eslint] #{m}\n(#{c})",
      condition = function(utils)
        return utils.root_has_file { ".eslintrc.js", ".eslintrc.cjs" } -- only enable if root has .eslintrc.js or .eslintrc.cjs
      end,
    },
    diagnostics.fish,
    diagnostics.vale,
  },
  root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
}

vim.api.nvim_create_user_command("DisableLspFormatting", function()
  vim.api.nvim_clear_autocmds { group = augroup, buffer = 0 }
end, { nargs = 0 })

-- local present, null_ls = pcall(require, "null-ls")

-- if not present then
-- return
-- end

-- local b = null_ls.builtins

-- local sources = {

-- webdev stuff
-- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
-- b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

-- Lua
-- b.formatting.stylua,

-- cpp
--   b.formatting.clang_format,
-- }
--
-- null_ls.setup {
--   debug = true,
--   sources = sources,
-- }
