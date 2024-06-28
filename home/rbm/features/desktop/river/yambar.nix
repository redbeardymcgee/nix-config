{
  programs.yambar = {
    enable = true;
    settings = rec {
      bg_default = {
        stack = [
          {
            background = { color = "181825FF"; };
          }
          {
            underline = { color = "BAC2DEFF"; size = 4; };
          }
        ];
      };
      font_default = "FiraCode Nerd Font:size=10";
      bar = {
        font = font_default;
        height = 40;
        location = "top";
        margin = 0;
        layer = "bottom";
        foreground = "EEEEEEFF";
        background = "2E3440DD";

      };
    };
  };
}
