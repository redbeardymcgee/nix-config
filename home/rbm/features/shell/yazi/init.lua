require("augment-command"):setup {
  prompt = false,
  default_item_group_for_prompt = "hovered",
  smart_enter = true,
  smart_paste = true,
  smart_tab_create = true,
  smart_tab_switch = true,
  confirm_on_quit = true,
  open_file_after_creation = false,
  enter_directory_after_creation = false,
  use_default_create_behaviour = false,
  enter_archives = true,
  extract_retries = 3,
  recursively_extract_archives = true,
  preserve_file_permissions = false,
  encrypt_archives = false,
  encrypt_archive_headers = false,
  reveal_created_archive = true,
  remove_archived_files = false,
  must_have_hovered_item = true,
  skip_single_subdirectory_on_enter = true,
  skip_single_subdirectory_on_leave = true,
  smooth_scrolling = true,
  scroll_delay = 0.02,
  create_item_delay = 0.25,
  wraparound_file_navigation = true,
}

require("bunny"):setup {
  hops = {
    { key = "/", path = "/" },
    { key = "n", path = "/nix/store", desc = "Nix store" },
    { key = "h", path = "~", desc = "Home" },
    { key = "d", path = "~/Downloads", desc = "Downloads" },
    { key = "D", path = "~/Documents", desc = "Documents" },
    { key = "c", path = "~/.config", desc = "Config files" },
    { key = { "l", "s" }, path = "~/.local/share", desc = "Local share" },
    { key = { "l", "b" }, path = "~/.local/bin", desc = "Local bin" },
    { key = { "l", "t" }, path = "~/.local/state", desc = "Local state" },
  },
  desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
  ephemeral = true, -- Enable ephemeral hops, default is true
  tabs = true, -- Enable tab hops, default is true
  notify = false, -- Notify after hopping, default is false
  fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
}

require("duckdb"):setup()
require("pref-by-location"):setup {}

require("full-border"):setup {
  type = ui.Border.ROUNDED,
}

require("recycle-bin"):setup()
require("restore"):setup()

-- Show username & hostname in header
Header:children_add(function()
  if ya.target_family() ~= "unix" then
    return ""
  end
  return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- Show symlink in status bar
Status:children_add(function(self)
  local h = self._current.hovered
  if h and h.link_to then
    return " -> " .. tostring(h.link_to)
  else
    return ""
  end
end, 3300, Status.LEFT)

-- Show user:group in status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    " ",
  }
end, 500, Status.RIGHT)
