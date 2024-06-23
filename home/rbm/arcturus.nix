{
  imports = [
    ./features/global

    ./features/cli
    ./features/desktop/river
    ./features/desktop/wayland

    ./features/services/mpris-proxy.nix
    ./features/services/playerctld.nix
    ./features/services/remmina.nix
    ./features/services/ssh-agent.nix
  ];
  #   -------    ------
  # | DVI-D-1 | | DP-3 |
  #   -------    ------
  # monitors = [
  #   {
  #     name = "DVI-D-1";
  #     width = 1920;
  #     height = 1080;
  #     x = 0;
  #     workspace = "1";
  #     primary = true;
  #   }
  #   {
  #     name = "DP-3";
  #     width = 3440;
  #     height = 2440;
  #     x = 1920;
  #     workspace = "2";
  #   }
  # ];
}
