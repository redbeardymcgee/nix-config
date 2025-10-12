{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./firefox
    # ./chromium.nix
    ./ghostty.nix
    ./kitty.nix
    ./protonvpn.nix
    ./thunderbird.nix
    # ./qutebrowser.nix

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs;
      [
        affine # does not add to PATH
        angryipscanner
        chatterino2
        flatpak
        fractal
        # google-chrome # TODO: allowUnfree isn't working
        jellyfin-media-player
        # kdePackages.kstatusnotifieritem
        ladybird
        moonlight-qt
        mpv
        nextcloud-talk-desktop
        # openshot-qt # nix run github:nixos/nixpkgs/nixos-24.05#openshot-qt
        pamixer
        # pw-viz # TODO: doesn't build
        qbittorrent
        qpwgraph
        remmina
        streamcontroller
        signal-desktop
        spotify
        slack # TODO: allowUnfree isn't working
        vlc
      ];
  };
}
