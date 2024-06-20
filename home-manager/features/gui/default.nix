{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./wayland
  ];
  home.packages = with pkgs; [
    helvum
    nyxt
    pamixer
  ];
}
