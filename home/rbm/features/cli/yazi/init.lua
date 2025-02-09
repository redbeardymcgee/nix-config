require("full-border"):setup()

require("augment-command"):setup({
    prompt = false,
    default_item_group_for_prompt = "hovered",
    smart_enter = true,
    smart_paste = true,
    smart_tab_create = true,
    smart_tab_switch = false,
    open_file_after_creation = false,
    enter_directory_after_creation = true,
    use_default_create_behaviour = false,
    enter_archives = true,
    extract_retries = 3,
    recursively_extract_archives = true,
    must_have_hovered_item = true,
    skip_single_subdirectory_on_enter = true,
    skip_single_subdirectory_on_leave = true,
    wraparound_file_navigation = true,
})

