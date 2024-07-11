{pkgs, ...}: {
  imports = [
    ./tmux.nix

    ./localhost.nix
    ./mcgeedia.nix
    ./yazi-plugins.nix
  ];

  home.packages = with pkgs; [
    # python312Packages.libtmux
    chafa
    ueberzugpp
  ];
}
