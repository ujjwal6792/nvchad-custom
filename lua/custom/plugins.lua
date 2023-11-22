local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
 {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
  "dsznajder/vscode-es7-javascript-react-snippets",
  run = "yarn install --frozen-lockfile && yarn compile",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {
      'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "NvChad/nvterm",
     opts = overrides.nvterm,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    'mg979/vim-visual-multi',
    setup = function()
      -- You can add any configuration/setup for vim-multiple-cursors here if needed
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function ()
      require('nvim-ts-autotag').setup({
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = false,
      })
    end,
    lazy = true,
    event = "VeryLazy"
  },
  {
    "charludo/projectmgr.nvim",
    lazy = false, -- important!
    config = function()
        require("projectmgr").setup({
            autogit = {
                enabled = true,
                command = "git pull --ff-only > .git/fastforward.log 2>&1",
            },
            session = { enabled = true, file = ".git/Session.vim" },
        })
    end,
  },
    { "nvim-lua/plenary.nvim", lazy = true },
    {
        "kdheepak/lazygit.nvim",
         lazy= false,
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
  -- rust plugins
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function(_)
      require("rust-tools").setup({
        server = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<Leader>k",  require("rust-tools").hover_actions.hover_actions, { buffer = bufnr, desc="rust-tools hover actions" })
      vim.keymap.set("n", "<Leader>a", require("rust-tools").code_action_group.code_action_group, { buffer = bufnr, desc="rust-tools code actions" })
    end,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
          assist = {
                importEnforceGranularity = true,
                importPrefix = 'crate',
            },
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = 'clippy',
            },
            inlayHints = { locationLinks = false },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
  },
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      -- require("core.utils").load_mappings "dap"
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"rust","toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    'RRethy/vim-illuminate',
    lazy=false
  },
  -- {"ellisonleao/glow.nvim",
  -- config = true, 
    -- config = function() require("glow").setup() end,
    -- cmd = "Glow"},
 -- {
 --    "iamcco/markdown-preview.nvim",
 --    build = "cd app && npm install",
 --    ft = "markdown",
 --    lazy = true,
 --    init = function() vim.g.mkdp_filetypes = { "markdown", "md" } end,
 --    keys = { { "gm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
 --    config = function()
 --      vim.g.mkdp_auto_close = false
 --      vim.g.mkdp_open_to_the_world = false
 --      vim.g.mkdp_open_ip = "127.0.0.1"
 --      vim.g.mkdp_port = "8888"
 --      vim.g.mkdp_browser = "firefox"
 --      vim.g.mkdp_echo_preview_url = true
 --      vim.g.mkdp_page_title = "${name}"
 --    end,
 --  },

    -- {
    --     'lukas-reineke/headlines.nvim',
    --     dependencies = "nvim-treesitter/nvim-treesitter",
    --     config = true, -- or `opts = {}`
    -- }
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  }

return plugins
