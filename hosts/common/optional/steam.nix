{
  lib,
  pkgs,
  ...
}: {
  hardware.graphics.extraPackages = [
    pkgs.gamescope-wsi
  ];
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--borderless"
      "--steam"
      "--expose-wayland"
      "--force-windows-fullscreen"
      "--adaptive-sync"
      "--mangoapp"
    ];
  };

  programs.gamemode = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        OBS_VKCAPTURE = true;
      };
      extraPkgs = pkgs':
        with pkgs'; [
          dxvk
          harfbuzz
          pango
          python3
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      # Automatically enable gamemode whenever Steam is running
      extraProfile = ''
        export LD_LIBRARY_PATH="${lib.getLib (pkgs.gamemode)}/lib:$LD_LIBRARY_PATH"
      '';
    };
    protontricks.enable = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
}
