{pkgs, ...}: {
  home.packages = [pkgs.onagre];

  wayland.windowManager = {
    river.settings.map.normal = {
      "None Menu" = "spawn onagre";
    };
  };
}
