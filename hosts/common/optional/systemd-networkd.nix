{
  systemd = {
    services = {
      "systemd-networkd" = {
        environment = {
          SYSTEMD_LOG_LEVEL = "debug";
        };
      };
    };
    enable = true;
    networks = {
      "10-lan" = {
        linkConfig.RequiredForOnline = "routable";
        matchConfig.Name = "enp0s31f6";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };
      };
    };
  };
}
