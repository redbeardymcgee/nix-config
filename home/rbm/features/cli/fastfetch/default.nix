let
  topFormat = "┌────────────────────────────────────────────────────────────┐";
  bottomFormat = "└────────────────────────────────────────────────────────────┘";

  colorSamples = " {#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90}";
  desktopKeyColor = "blue";
  hwKeyColor = "green";
  osKeyColor = "yellow";
  sepColor = "90";
in {
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = ./nixos.png;
        type = "sixel";

        padding = {
          top = 2;
          left = 2;
        };
      };

      display = {
        separator = " ";
      };

      modules = [
        {
          type = "custom";
          format = topFormat;
          outputColor = sepColor;
        }
        {
          type = "title";
          keyWidth = 10;
        }
        {
          type = "custom";
          format = bottomFormat;
          outputColor = sepColor;
        }
        {
          type = "custom";
          format = colorSamples;
        }
        {
          type = "custom";
          format = topFormat;
          outputColor = sepColor;
        }
        {
          type = "os";
          key = " ";
          keyColor = osKeyColor;
        }
        {
          type = "kernel";
          key = "│ ├ ";
          keyColor = osKeyColor;
        }
        {
          type = "packages";
          key = "│ ├󰏖 ";
          keyColor = osKeyColor;
        }
        {
          type = "shell";
          key = "│ └ ";
          keyColor = osKeyColor;
        }
        {
          type = "custom";
          format = bottomFormat;
        }
        "break"
        {
          type = "custom";
          format = topFormat;
        }
        {
          type = "wm";
          key = " ";
          keyColor = desktopKeyColor;
        }
        {
          type = "lm";
          key = "│ ├󰧨 ";
          keyColor = desktopKeyColor;
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼 ";
          keyColor = desktopKeyColor;
        }
        {
          type = "icons";
          key = "│ ├󰀻 ";
          keyColor = desktopKeyColor;
        }
        {
          type = "terminal";
          key = "│ ├ ";
          keyColor = desktopKeyColor;
        }
        {
          type = "wallpaper";
          key = "│ └󰸉 ";
          keyColor = desktopKeyColor;
        }
        {
          type = "custom";
          format = bottomFormat;
        }
        "break"
        {
          type = "custom";
          format = topFormat;
        }
        {
          type = "host";
          key = "󰌢 ";
          keyColor = hwKeyColor;
        }
        {
          type = "cpu";
          key = "│ ├󰻠 ";
          keyColor = hwKeyColor;
        }
        {
          type = "gpu";
          key = "│ ├󰍛 ";
          keyColor = hwKeyColor;
        }
        {
          type = "disk";
          key = "│ ├ ";
          keyColor = hwKeyColor;
        }
        {
          type = "memory";
          key = "│ ├󰑭 ";
          keyColor = hwKeyColor;
        }
        {
          type = "swap";
          key = "│ ├󰓡 ";
          keyColor = hwKeyColor;
        }
        {
          type = "display";
          key = "│ ├󰍹 ";
          keyColor = hwKeyColor;
        }
        {
          type = "uptime";
          key = "│ └󰅐 ";
          keyColor = hwKeyColor;
        }
        {
          type = "custom";
          format = bottomFormat;
          outputColor = sepColor;
        }
        {
          type = "custom";
          format = colorSamples;
        }
      ];
    };
  };
}
