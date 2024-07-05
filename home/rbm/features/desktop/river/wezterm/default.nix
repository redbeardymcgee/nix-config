{
  xdg.configFile."wezterm/utils.lua" = {
    enable = true;
    source = ./utils.lua;
  };

  programs.wezterm = {
    enable = true;

    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
