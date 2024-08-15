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

require("full-border"):setup()
require("yamb"):setup {}

require("augment-command"):setup({
    prompt = false,
    default_item_group_for_prompt = "hovered",
    smart_enter = true,
    smart_paste = true,
    enter_archives = true,
    extract_behaviour = "skip",
    must_have_hovered_item = true,
    skip_single_subdirectory_on_enter = true,
    skip_single_subdirectory_on_leave = true,
    ignore_hidden_items = false,
    wraparound_file_navigation = true,
})

-- require("yaziline"):setup({
--   separator_style = "angly",
--   filename_max_length = 24,
--   filename_trim_length = 6,
--   select_symbol = "",
--   yank_symbol = "󰆐",
-- })

-- require("git-status"):setup{
--     folder_size_ignore = {"/home/rbm","/"},
--     gitstatus_ignore = {"/home/rbm","/"},
--     enable_folder_size = true
-- }
