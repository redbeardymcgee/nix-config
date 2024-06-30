{pkgs, ...}: {
  home.packages = with pkgs; [
    way-displays
  ];

  # xdg.configFile."way-displays/cfg.yaml".source = (pkgs.formats.yaml {}).generate "cfg.yaml" {
  # };
  xdg.configFile."way-displays/cfg.yaml".text = ''
    MODE:
      - NAME_DESC: "BNQ BenQ XL2420Z 41E09757SL0 (DVI-D-1)"
        MAX: TRUE
      - NAME_DESC: "Samsung Electric Company SE790C (DP-3)"
        MAX: TRUE

    ORDER:
      - '!^DVI-D-.*'
      - '!DP-.*'

    SCALE:
      - NAME_DESC: "Samsung Electric Company SE790C (DP-3)"
        SCALE: 1.25

    VRR_OFF:
      - "SE790C"
      - "BenQ XL2420Z"
  '';
}
