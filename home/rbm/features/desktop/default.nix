{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    # ./xdg-terminal-exec.nix
  ];

  home.packages = with pkgs; [
    element-desktop
    # firefox
    # libnotify
    nyxt
    pamixer
    qpwgraph
    vesktop
  ];
}
