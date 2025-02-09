{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./firefox
    ./kitty.nix
    ./thunderbird.nix
    ./qutebrowser.nix
    ./ghostty.nix

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs;
      [
        angryipscanner
        chromium # TODO: allowUnfree isn't working
        flatpak
        fractal
        # google-chrome # TODO: allowUnfree isn't working
        jellyfin-media-player
        # kdePackages.kstatusnotifieritem
        moonlight-qt
        mpv
        # openshot-qt # nix run github:nixos/nixpkgs/nixos-24.05#openshot-qt
        pamixer
        # pw-viz # TODO: doesn't build
        qbittorrent
        qpwgraph
        remmina
        streamcontroller
        # signal-desktop
        spotify
        # slack # TODO: allowUnfree isn't working
        vlc
      ];
  };
}
