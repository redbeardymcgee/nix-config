local M = {}

function M.startup(wezterm, workspace_name)
	local mux = wezterm.mux
	local config_dir = wezterm.home_dir .. ".config"

	local dotfiles_tab, dotfiles_pane, dotfiles_window = mux.spawn_window({
		workspace = workspace_name,
		cwd = config_dir,
	})

	dotfiles_tab:set_title("dotfiles")
	dotfiles_pane:split({ direction = "Right" })
	dotfiles_pane:activate({ args = { "nvim-nightly", "." } })
end
