local M = {}

M.cmp = {
  sources = {
    name = "crates"
  }
}

M.treesitter = {
  ensure_installed = {
    "astro",
    "scss",
    "svelte",
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
     "tsx",
    "c",
    "rust",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  context_commentstring = {
    enable_autocmd = false,
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "prettierd",
    "tailwindcss-language-server",
    "vale",
    "cssmodules-language-server",
    "css-lsp",
    "eslint-lsp",
    "eslint_d",
    -- rust stuff
    "rust-analyzer",
    -- go stuff 
    "gopls",
    "golangci-lint",
    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

M.nvterm = {
terminals = {
    shell = vim.o.shell,
    list = {},
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.05,
        col = 0.05,
        width = 0.9,
        height = 0.8,
        border = "double",
        location = "center",
      },
      horizontal = { location = "rightbelow", split_ratio = .5, },
      vertical = { location = "rightbelow", split_ratio = .7 },
    }
  },
  behavior = {
    autoclose_on_quit = {
      enabled = false,
      confirm = true,
    },
    close_on_exit = true,
    auto_insert = true,
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}



return M
