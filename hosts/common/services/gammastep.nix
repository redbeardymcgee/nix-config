{
  services.geoclue2.enable = true;

  services.gammastep = {
    enable = true;
    tray = false;
    provider = "geoclue2";

    # dawnTime = "06:30";
    # duskTime = "20:00";
  };
}
