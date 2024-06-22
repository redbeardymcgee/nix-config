{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./global

    ./global/features/gui/gamemode.nix
    ./global/features/desktop/river
    # ./features/desktop/hyprland
    # ./features/rgb
    # ./features/productivity
    # ./features/pass
    # ./features/games
    # ./features/games/star-citizen.nix
    # ./features/games/yuzu.nix
  ];

  #  ------   -----   ------
  # | DP-3 | | DP-1| | DP-2 |
  #  ------   -----   ------
  # monitors = [
  #   {
  #     name = "DP-3";
  #     width = 1920;
  #     height = 1080;
  #     x = 0;
  #     workspace = "3";
  #     enabled = false;
  #   }
  #   {
  #     name = "DP-1";
  #     width = 2560;
  #     height = 1080;
  #     x = 1920;
  #     workspace = "1";
  #     primary = true;
  #   }
  #   {
  #     name = "DP-2";
  #     width = 1920;
  #     height = 1080;
  #     x = 4480;
  #     workspace = "2";
  #   }
  # ];
}
