{pkgs, ...}: {
  home.packages = let
    setRes = pkgs.writeShellScriptBin "setres" ''      #bash

       if [[ $1 == game ]]
       then
         way-displays -d scale "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817"
         way-displays -s mode "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817" 1920 1080 120
       else
         way-displays -s mode "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817" 2560 1440 180
         way-displays -s scale "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817" 1.5
       fi

    '';
  in [
    pkgs.way-displays
    setRes
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
      ];

      ORDER = [
        samsung
        asus
      ];

      SCALE = [
        {
          NAME_DESC = samsung;
          SCALE = 1.50;
        }
        {
          NAME_DESC = asus;
          SCALE = 1.50;
        }
      ];

      VRR_OFF = [
        samsung
      ];
    };
  };
}
