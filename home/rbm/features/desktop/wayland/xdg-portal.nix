{pkgs, ...}: {
  xdg = {
    portal = {
      enable = true;

      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.portal.Screenshot" = "luminous";
          "org.freedesktop.portal.Screencast" = "luminous";
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-luminous
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];

      xdgOpenUsePortal = true;
    };
  };
}
