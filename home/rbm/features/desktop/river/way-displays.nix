{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    way-displays
  ];

  xdg.configFile."way-displays/cfg.yaml".text = lib.generators.toJSON {} {
    mode = [
      {
        name_desc = "BNQ BenQ XL2420Z 41E09757SL0 (DVI-D-1)";
        max = true;
      }
      {
        name_desc = "Samsung Electric Company SE790C (DP-3)";
        max = true;
      }
    ];

    order = [
      "'!^DVI-D-.*'"
      "'!DP-.*'"
    ];

    scale = [
      ''name_desc = "Samsung Electric Company SE790C (DP-3)"''
      "scale = 1.25"
    ];
  };
}
