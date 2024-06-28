{pkgs, ...}: {
  imports = [
    ./firefox.nix
    # ./xdg-terminal-exec.nix
  ];

  home.packages = with pkgs; [
    element-desktop
    nyxt
    pamixer
    qpwgraph
    vesktop
  ];
}
