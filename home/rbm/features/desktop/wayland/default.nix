{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./obs-studio.nix
    ./xdg-portal.nix
  ];

  home.packages = with pkgs; [
    lswt
    (vesktop.override {
      withSystemVencord = false;
    })
    wl-clipboard
    wl-screenrec
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
