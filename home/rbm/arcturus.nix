{ pkgs, ... }: {
  imports = [
    ./features/global

    ./features/cli
    ./features/desktop
    ./features/desktop/river
    ./features/desktop/wayland
  ];

  home.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
