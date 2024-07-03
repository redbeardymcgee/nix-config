{pkgs, ...}: {
  imports = [
    ./firefox.nix
    # ./xdg-terminal-exec.nix
  ];

  gtk.enable = true;
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home = {
    packages = with pkgs; [
      element-desktop
      nyxt
      pamixer
      qpwgraph
      vesktop
    ];

    # pointerCursor = {
    #   x11.enable = true;
    #   gtk.enable = true;
    # };
  };

}
