{pkgs, ...}: {
  home.packages = with pkgs; [
    way-displays
  ];

  xdg.configFile."way-displays/cfg.yaml".source = (pkgs.formats.yaml {}).generate "cfg.yaml" {
    MODE = [
      {
        NAME_DESC = "BNQ BenQ XL2420Z 41E09757SL0 (DVI-D-1)";
        MAX = true;
      }
      {
        NAME_DESC = "Samsung Electric Company SE790C (DP-3)";
        MAX = true;
      }
    ];

    ORDER = [
      "'DP-3'"
      "'DVI-D-1'"
    ];

    SCALE = [
      {
        NAME_DESC = "Samsung Electric Company SE790C (DP-3)";
        SCALE = 1.50;
      }
    ];

    VRR_OFF = [
      "SE790C"
      "BenQ XL2420Z"
    ];
  };
}
