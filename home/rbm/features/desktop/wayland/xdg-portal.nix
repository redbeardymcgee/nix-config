{pkgs, ...}: {
  xdg = {
    portal = {
      enable = true;

      config = {
        common = {
          default = [
            "gtk"
          ];
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];

      xdgOpenUsePortal = true;
    };
  };
}
