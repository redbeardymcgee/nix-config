{pkgs, ...}: {
  imports = [
    ./localhost.nix
    ./mcgeedia.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    python311Packages.libtmux
  ];
}
