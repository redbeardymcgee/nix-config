-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local uv = vim.loop

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("lazyvim_autoupdate", { clear = true }),
  callback = function()
    require("lazy").update({
      show = false,
    })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.env.TMUX_PLUGIN_MANAGER_PATH then
      uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
    end
  end,
})
