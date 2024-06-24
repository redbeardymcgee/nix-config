{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./xdg-portal.nix
  ];
  home.packages = with pkgs; [
    wayshot
  ];
  home.sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      WLR_NO_HARDWARE_CURSORS = "1";
  };
  xdg = {
    portal = {
      enable = true;
      config = {
        common = {
          default = [
            "wlr"
            "gtk"
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
  };
}
