{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./apps/davinci.nix
    # ./apps/firefox
    ./apps/ghostty.nix
    ./apps/kitty.nix
    ./apps/mangohud.nix
    # ./apps/protonvpn.nix
    ./apps/qutebrowser.nix
    ./apps/streamlink.nix
    ./apps/thunderbird.nix

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs; [
      affine
      # bitwarden-desktop
      gimp
      grayjay
      jellyfin-desktop
      inkscape-with-extensions
      # ladybird
      moonlight-qt
      mpv
      nextcloud-talk-desktop
      notesnook
      pixieditor
      pw-viz # TODO: crashy
      qbittorrent
      qpwgraph
      signal-desktop
      streamcontroller
      supersonic-wayland
      supersonic
      vlc
    ];
  };
}
