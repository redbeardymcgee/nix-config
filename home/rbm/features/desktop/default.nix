{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./davinci.nix
    ./firefox
    ./ghostty.nix
    ./kitty.nix
    ./mangohud.nix
    # ./protonvpn.nix
    ./qutebrowser.nix
    ./streamlink.nix
    ./thunderbird.nix

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs;
      [
        bitwarden-desktop
        gimp
        grayjay
        jellyfin-desktop
        inkscape-with-extensions
        ladybird
        moonlight-qt
        mpv
        nextcloud-talk-desktop
        # pixieditor
        pw-viz # TODO: crashy
        qbittorrent
        qpwgraph
        signal-desktop
        streamcontroller
        # supersonic-wayland
        supersonic
        vlc
      ]
      ++ (with pkgs-unstable; [
        pixieditor
        # grayjay
      ]);
  };
}
