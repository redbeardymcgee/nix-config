{ pkgs, ... }: {
  imports = [
    ./foot.nix
    ./fnott.nix
    ./river.nix
    ./tofi.nix
    ./way-displays.nix
  ];
  home.packages = with pkgs; [
    element-desktop
    vesktop
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
