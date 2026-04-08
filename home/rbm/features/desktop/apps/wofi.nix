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
}
