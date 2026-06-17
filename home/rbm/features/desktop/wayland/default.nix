{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./obs-studio.nix
    ./wpaperd.nix
    ./xdg-portal.nix

    # ../../services/cliphist.nix
    # ../../services/mpris-proxy.nix
    # ../../services/playerctld.nix
    ../../services/ssh-agent.nix
    ../../services/udiskie.nix
    ../../services/wl-clip-persist.nix
  ];

  home.packages = with pkgs; [
    lswt
    wl-clipboard
    wl-screenrec
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_BACKENDS = "headless,wayland";
    # WLR_HEADLESS_OUTPUTS = "2";
  };
}
