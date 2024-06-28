{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./xdg-portal.nix
  ];
  home.packages = with pkgs; [
    lswt
    wayshot
  ];
  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = 1;
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
