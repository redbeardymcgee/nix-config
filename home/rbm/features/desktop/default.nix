{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./firefox
    ./ghostty.nix
    ./kitty.nix
    ./protonvpn.nix
    ./qutebrowser.nix
    ./thunderbird.nix

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs; [
      # affine
      chatterino2
      # davinci-resolve
      # fractal
      grayjay
      jellyfin-media-player
      ladybird
      moonlight-qt
      mpv
      nextcloud-talk-desktop
      pixieditor
      pw-viz # TODO: crashy
      qbittorrent
      qpwgraph
      streamcontroller
      signal-desktop
      # slack
      vlc
    ];
  };
}
