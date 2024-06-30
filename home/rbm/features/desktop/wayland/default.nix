{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./xdg-portal.nix
  ];

  home.packages = with pkgs; [
    cliphist
    lswt
    wayshot
    wl-clipboard
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
