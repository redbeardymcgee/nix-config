{pkgs, ...}: {
  services.wpaperd = {
  # programs.wpaperd = {
    enable = true;
    settings.default.path = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qzelxl.jpg";
      hash = "sha256-WVXnEV/SHMZ0idEsLe/gdSM4gS29xsx+r9SnSnI56ts=";
    };
  };
}
