{pkgs, ...}: {
  home.packages = let
    setRes = pkgs.writeShellScriptBin "setres" ''      #bash

       if [[ $1 == game ]]
       then
         way-displays -s mode "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817" 1920 1080 120
       else
         systemctl --user restart way-displays
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

      VRR_OFF = [
        samsung
      ];
    };
  };
}
