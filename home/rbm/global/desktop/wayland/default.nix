{ pkgs, ... }: {
  imports = [
    ./firefox.nix
  ];
  home.packages = with pkgs; [
    wayshot
  ];
  home.sessionVariables = {
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
