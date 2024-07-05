{pkgs, ...}: {
  imports = [
    ./firefox.nix
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
