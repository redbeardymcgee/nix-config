local M = {}

function M.startup(wezterm)
	local mux = wezterm.mux
	local containers_dir = "/opt/containers"
	local workspace_name = "McGeedia"

	mux.set_default_domain("McGeedia")

	local mcgeedia_tab, mcgeedia_pane, mcgeedia_window = mux.spawn_window({
		cwd = containers_dir,
		workspace = workspace_name,
	})

	mcgeedia_window:set_title("McGeedia")
	mcgeedia_tab:set_title("Shell")

	local containers_tab, containers_pane, containers_window = mcgeedia_window:spawn_tab()

	containers_tab:set_title("Containers")
	containers_pane:split({
		{ direction = "Right", args = { "nvim-nightly", "." } },
	})

	mux.set_active_workspace(workspace_name)
end
return M
