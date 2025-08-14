{pkgs, ...}: {
  home.packages = [pkgs.gradia];

  wayland.windowManager.river.settings.map.normal = {
    "None Print" = ''spawn 'flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE' '';
  };
}
