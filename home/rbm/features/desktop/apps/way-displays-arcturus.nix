{pkgs, ...}: {
  # services.way-displays = let
  # programs.way-displays = let
  #   benq = "BNQ BenQ XL2420Z 41E09757SL0";
  #   samsung = "Samsung Electric Company SE790C";
  # in {
  home.packages = [pkgs.way-displays];

  xdg.configFile."way-displays/cfg.yaml".source = let
    benq = "BNQ BenQ XL2420Z 41E09757SL0";
    samsung = "Samsung Electric Company SE790C";
  in
    (pkgs.formats.yaml {}).generate "cfg.yaml" {
      enable = true;
      settings = {
        MODE = [
          {
            NAME_DESC = benq;
            MAX = true;
          }
          {
            NAME_DESC = samsung;
            MAX = true;
          }
        ];

        ORDER = [
          samsung
          benq
        ];

        SCALE = [
          {
            NAME_DESC = samsung;
            SCALE = 1.50;
          }
        ];

        VRR_OFF = [
          samsung
          benq
        ];
      };
    };
}
