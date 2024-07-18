-- require("searchjump"):setup {
--     unmatch_fg = "#a6adc8",
--     match_str_fg = "#cba6f7",
--     match_str_bg = "#7f849c",
--     lable_bg = "#6c7086",
--     lable_fg = "#000000",
--     only_current = false, -- only search the current window
--     show_search_in_statusbar = true,
--     auto_exit_when_unmatch = true,
--     search_patterns = {}  -- demo:{"%.e%d+","s%d+e%d+"}
-- }

require("yamb"):setup {}

require("full-border"):setup()

-- require("git-status"):setup{
--     folder_size_ignore = {"/home/rbm","/"},
--     gitstatus_ignore = {"/home/rbm","/"},
--     enable_folder_size = true
-- }

require("yaziline"):setup({
  separator_style = "curvy",
  select_symbol = "",
  yank_symbol = "󰆐",
})
