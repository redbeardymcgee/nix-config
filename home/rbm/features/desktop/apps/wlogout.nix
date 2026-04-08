{
  programs.wlogout = {
    enable = true;
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super+Alt L" = "spawn 'wlogout -s'";
    };
  };
}
