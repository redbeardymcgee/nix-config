{pkgs, ...}: {
  imports = [
    ./tmux.nix

    ./localhost.nix
    ./mcgeedia.nix
    ./yazi-plugins.nix
  ];

  home.packages = with pkgs; [
    python311Packages.libtmux
    chafa
    ueberzugpp
  ];
}
