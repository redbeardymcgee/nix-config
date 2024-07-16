local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config = {
  enable_tab_bar = false,
  scrollback_lines = 3500,

  harfbuzz_features = {
    "zero", -- 0
    "cv17", -- ~
    "ss05", -- @
    "cv16", -- *
    -- "cv27", -- []
    "cv29", -- {}
    "cv31", -- ()
    "cv30", -- ||
    "cv23", -- >=
    "ss08", -- == === != !==
    "ss09", -- >>= <<= ||= |=
    "cv25", -- .-
    "cv26", -- :-
    "cv32", -- .=
    "cv28", -- {. .}
    "ss06", -- \\
    "ss07", -- =~ !~
  },

  inactive_pane_hsb = {
    hue = 1.0,
    saturation = 0.9,
    brightness = 0.4,
  },

}

wezterm.on("update-status", function(window, pane)
	local meta = pane:get_metadata() or {}
	local overrides = window:get_config_overrides() or {}
	if meta.password_input then
		overrides.color_scheme = "Red Alert"
	else
		overrides.color_scheme = nil
	end
	window:set_config_overrides(overrides)
end)

return config
