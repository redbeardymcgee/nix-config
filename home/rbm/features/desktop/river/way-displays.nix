{
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
