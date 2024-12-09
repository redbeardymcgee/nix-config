{...}: {
  services.fnott = {
    enable = false;
    settings = {
      main = {
        dpi-aware = "yes";
        background = "6c7086ff";
        body-color = "cdd6f4ff";
        body-font = "FiraCode Nerd Font:size=12";
        border-color = "b4befeff";
        progress-bar-color = "9399b2ff";
        selection-helper = "fuzzel -d";
        summary-color = "cdd6f4ff";
        summary-font = "FiraCode Nerd Font:size=12";
        title-color = "cdd6f4ff";
        title-font = "FiraCode Nerd Font:size=14";
      };
    };
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super D" = "spawn 'fnottctl dismiss'";
      "Super+Shift D" = "spawn 'fnottctl dismiss all'";
      "Super+Alt D" = "spawn 'fnottctl actions'";
    };
  };
}
