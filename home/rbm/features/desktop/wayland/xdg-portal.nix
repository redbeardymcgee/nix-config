{ pkgs, ... }: {
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
        # xdg-desktop-portal-luminous
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      xdgOpenUsePortal = true;
    };
  };

}
