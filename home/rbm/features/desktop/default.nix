{pkgs, ...}: {
  imports = [
    ./firefox

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt.enable = true;

  home = {
    packages = with pkgs; [
      flatpak
      fractal
      jellyfin-media-player
      moonlight-qt
      pamixer
      # pw-viz # TODO: doesn't build
      qbittorrent-enhanced
      qpwgraph
      remmina
      vlc
    ];
  };
}
