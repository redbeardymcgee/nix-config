{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # wayland.windowManager = {
  #   river.settings.map.normal = {
  #     "Super Space" = "spawn 'wezterm start --always-new-process --class wezterm_localhost -- tmuxp load -y localhost'";
  #   };
  # };

  xdg.configFile."wezterm/utils.lua" = {
    enable = true;
    source = ./utils.lua;
  };
}
