{pkgs, ...}: {
  imports = [
    ./firefox

    ../services/gammastep.nix
  ];

  gtk.enable = true;
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home = {
    packages = with pkgs; [
      fractal
      nyxt
      pamixer
      # pw-viz # TODO: doesn't build
      qpwgraph
    ];
  };
}
