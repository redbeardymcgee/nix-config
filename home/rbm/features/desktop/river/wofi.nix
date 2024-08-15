{
  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      allow_markup = true;
      gtk_dark = true;
      hide_scroll = true;
      insensitive = true;
      matching = "multi-contains";
      parse_search = true;

      key_expand = "Tab";
      key_up = "Ctrl-p";
      key_down = "Ctrl-n";
      key_left = "Ctrl-h";
      key_right = "Ctrl-l";
    };
  };

  wayland.windowManager.river.settings.map.normal = {
    "None Menu" = "spawn 'wofi --show drun'";
    "Super Menu" = "spawn 'wofi --show run'";
    "Super V" = "spawn 'cliphist list | wofi -S dmenu | cliphist decode | wl-copy'";
  };
}
