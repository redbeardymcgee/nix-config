{
  lib,
  pkgs,
  ...
}: {
  programs.java.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      # withJava = true;
      extraPkgs = pkgs:
        with pkgs; [
          dxvk
          gamemode
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
      # extraLibraries = pkgs: [ pkgs.gperftools ];
      # Automatically enable gamemode whenever Steam is running
      extraProfile = ''
        export LD_LIBRARY_PATH="${lib.getLib (pkgs.gamemode)}/lib:$LD_LIBRARY_PATH"
      '';
    };

    protontricks.enable = true;

    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    gamescopeSession = {
      enable = true;
    };
  };
}
