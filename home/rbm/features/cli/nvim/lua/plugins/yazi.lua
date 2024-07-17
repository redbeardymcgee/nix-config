return {
  {
    ---@type LazySpec
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    ---@type LazySpec
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "-",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager",
      },
      {
        "<leader>fw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>fe",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager",
      },
    },
    opts = {
      open_for_directories = true,
      -- an upcoming optional feature. See
      -- https://github.com/mikavilpas/yazi.nvim/pull/152
      use_ya_for_events_reading = true,

      -- an upcoming optional feature. See
      -- https://github.com/mikavilpas/yazi.nvim/pull/180
      highlight_groups = {
        -- NOTE: this only works if `use_ya_for_events_reading` is enabled, etc.
        hovered_buffer = nil,
      },

      -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
      floating_window_scaling_factor = 0.8,

      -- the transparency of the yazi floating window (0-100). See :h winblend
      yazi_floating_window_winblend = 0,

      -- the log level to use. Off by default, but can be used to diagnose
      -- issues. You can find the location of the log file by running
      -- `:checkhealth yazi` in Neovim. Also check out the "reproducing issues"
      -- section below
      log_level = vim.log.levels.OFF,
    },
  }
}
-- return {
--   {
--     ---@type LazySpec
--     "nvim-neo-tree/neo-tree.nvim",
--     enabled = false,
--   },
--
--   {
--     ---@type LazySpec
--     "mikavilpas/yazi.nvim",
--     event = "VeryLazy",
--     keys = {
--       -- 👇 in this section, choose your own keymappings!
--       {
--         "-",
--         function()
--           require("yazi").yazi()
--         end,
--         desc = "Open the file manager",
--       },
--       {
--         "<leader>fe"
--         function()
--           require("yazi").yazi()
--         end,
--         desc = "Open the file manager",
--       },
--       {
--         -- Open in the current working directory
--         "<leader>fw",
--         function()
--           require("yazi").yazi(nil, vim.fn.getcwd())
--         end,
--         desc = "Open the file manager in nvim's working directory" ,
--       },
--     },
--     ---@type YaziConfig
--     opts = {
--       -- if you want to open yazi instead of netrw, see below for more info
--       open_for_directories = true,
--
--       -- an upcoming optional feature. See
--       -- https://github.com/mikavilpas/yazi.nvim/pull/152
--       use_ya_for_events_reading = false,
--
--       -- an upcoming optional feature. See
--       -- https://github.com/mikavilpas/yazi.nvim/pull/180
--       highlight_groups = {
--         -- NOTE: this only works if `use_ya_for_events_reading` is enabled, etc.
--         hovered_buffer = nil,
--       },
--
--       -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
--       floating_window_scaling_factor = 0.9,
--
--       -- the transparency of the yazi floating window (0-100). See :h winblend
--       yazi_floating_window_winblend = 0,
--
--       -- the log level to use. Off by default, but can be used to diagnose
--       -- issues. You can find the location of the log file by running
--       -- `:checkhealth yazi` in Neovim. Also check out the "reproducing issues"
--       -- section below
--       log_level = vim.log.levels.OFF,
--     },
--   }
-- }

