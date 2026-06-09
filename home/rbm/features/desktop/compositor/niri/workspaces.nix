{
  programs.niri.settings.workspaces = let
    asus = "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817";
    samsung = "Samsung Electric Company SE790C Unknown";
  in {
    "main" = {
      name = "main";
      open-on-output = asus;
    };
  };
}
