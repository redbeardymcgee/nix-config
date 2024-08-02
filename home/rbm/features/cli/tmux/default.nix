{pkgs, ...}: {
  imports = [
    ./tmux.nix

    ./localhost.nix
    ./mcgeedia.nix
    ./projects.nix
  ];

  home.packages = with pkgs; [
    python312Packages.libtmux
    chafa
  ];
}
