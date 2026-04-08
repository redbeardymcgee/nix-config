{pkgs, ...}: {
  home.packages = [pkgs.gradia];

  wayland.windowManager.river.settings.map.normal = {
    "None Print" = ''spawn "gradia --screenshot"'';
    "Super Print" = ''spawn gradia'';
  };
}
