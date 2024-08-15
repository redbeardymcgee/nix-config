{pkgs, ...}: {
  imports = [
    ./firefox

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt = {
    enable = true;
    #   platformTheme.name = "kvantum";
    #   style.name = "kvantum";
  };

  home = {
    packages = with pkgs; [
      flatpak
      fractal
      jellyfin-media-player
      # nyxt
      pamixer
      # pw-viz # TODO: doesn't build
      qbittorrent-enhanced
      qpwgraph
      remmina
      vlc
    ];
  };
}
