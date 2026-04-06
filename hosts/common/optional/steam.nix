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
    enableRenice = true;
    settings = {
      general = {
        reaper_freq = 5;
        desiredgov = "performance";
        softrealtime = "on";
        renice = 10;
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        amd_performance_level = "high";
      };
    };
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
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          pango
          python3
          stdenv.cc.cc.lib
          xorg.libXScrnSaver
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXxf86vm
        ];
      # Automatically enable gamemode whenever Steam is running
      extraProfile = ''
        export LD_LIBRARY_PATH="${lib.getLib (pkgs.gamemode)}/lib:$LD_LIBRARY_PATH"
      '';
    };
    gamescopeSession.enable = true;
    protontricks.enable = true;
    # extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
}
