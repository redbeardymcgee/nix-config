{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };

    settings = {
      font_features = "FiraCodeNerdFontMono-Regular +zero";
      wayland_enable_ime = "no";
      enable_audio_bell = "no";
      initial_window_width = "150c";
      initial_window_height = "40c";
      remember_window_size = "no";
    };
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super Space" = "spawn 'kitty --app-id terminal_localhost tmuxp load -y localhost'";
    };
  };
}
