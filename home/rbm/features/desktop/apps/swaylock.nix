{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      font = "FiraCode Nerd Font";
      indicator-caps-lock = true;
      show-failed-attempts = true;
    };
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super+Shift Q" = "spawn 'swaylock'";
    };
  };
}
