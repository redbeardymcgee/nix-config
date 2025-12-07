{
  lib,
  pkgs,
  ...
}: {
  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  # };

  programs.gamemode = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    # package = pkgs.steam.overrideAttrs (old: {
    #   postInstall =
    #     old.postInstall
    #     + ''
    #       sed -i 's:PrefersNonDefaultGPU=true::' $out/share/applications/steam.desktop
    #     '';
    # });
    package = pkgs.steam.override {
      extraPkgs = pkgs':
        with pkgs'; [
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
      # extraLibraries = pkgs': [pkgs'.gperftools];
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
