{pkgs, ...}: {
  home.packages = let
    gameres =
      pkgs.writeShellScriptBin "gameres"
      #bash
      ''
        width=$(way-displays -yg | yq '.STATE.HEADS.[] | select(.NAME == "DP-4").CURRENT.MODE.WIDTH')
        if (( $width != 1920 ))
        then
          way-displays -s mode "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817" 1920 1080 120
        else
          systemctl --user restart way-displays
        fi
      '';
  in [
    pkgs.way-displays
    gameres
  ];

  services.way-displays = {
    enable = true;
    settings = let
      asus = "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817";
      samsung = "Samsung Electric Company SE790C";
    in {
      MODE = [
        {
          NAME_DESC = asus;
          MAX = true;
        }
        {
          NAME_DESC = samsung;
          MAX = true;
        }
        {
          NAME_DESC = "!^DP-7$";
          MAX = true;
        }
        {
          NAME_DESC = "!^DP-8$";
          MAX = true;
        }
      ];

      ORDER = [
        samsung
        asus
        "!^DP-7$"
        "!^DP-8$"
      ];

      VRR_OFF = [
        samsung
      ];

      DISABLED = [
        {
          NAME_DESC = "!^DP-7$";
        }
        {
          NAME_DESC = "!^DP-8$";
        }
      ];
    };
  };
}
