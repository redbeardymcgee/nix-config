{pkgs, ...}: {
  home.packages = [pkgs.gradia];

  wayland.windowManager.river.settings.map.normal = {
    "None Print" = "gradia";
  };
}
