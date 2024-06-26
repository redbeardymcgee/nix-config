{ pkgs, ... }: {
  xdg = {
    portal = {
      enable = true;
      # config = {
      #   common = {
      #     default = [
      #       "wlr"
      #     ];
      #   };
      # };
      configPackages = with pkgs; [
        # xdg-desktop-portal-luminous
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
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
