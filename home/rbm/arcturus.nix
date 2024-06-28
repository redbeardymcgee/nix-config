{ pkgs, ... }: {
  imports = [
    ./features/global

    ./features/cli
    ./features/desktop
    ./features/desktop/river
    ./features/desktop/wayland

    ./features/services/udisks2.nix
  ];

  home.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
