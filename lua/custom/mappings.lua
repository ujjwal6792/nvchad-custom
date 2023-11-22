local function dummyFunction()
  -- Dummy function with an empty action
end

---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-d>"] = { "Find Under", "description for Find Under" },
    ["<leader>fp"] = { "<cmd> ProjectMgr<CR>", "Open Projects"},
    ["<leader>gg"] = { "<cmd> :LazyGit<CR>", "open lazygit" },
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "debugger toggle breakpoints" },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  },
  t = {
    ["<C-x>"] = { dummyFunction, "dummy description", opts = { nowait = true } }, -- Assign the dummy function
    ["<C-t>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" }
  },
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}
-- more keybinds!

return M









