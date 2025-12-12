{
  programs.regreet = {
    enable = true;

    cageArgs = ["-s" "-m" "last"];

    settings = {
      # env = {
      #   ENV_VARIABLE = "value";
      # };

      GTK = {
        application_prefer_dark_theme = true;
        cursor_blink = true;
      };

      commands = {
        reboot = ["systemctl" "reboot"];
        poweroff = ["systemctl" "poweroff"];
      };

      appearance = {
        greeting_msg = "Welcome back!";
      };

      widget.clock = {
        # strftime format argument
        # See https://docs.rs/jiff/0.1.14/jiff/fmt/strtime/index.html#conversion-specifications
        format = "%a %H:%M";
        resolution = "500ms";
        label_width = 150;
      };
    };
  };
}
