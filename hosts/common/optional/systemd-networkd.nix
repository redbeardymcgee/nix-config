{
  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    useDHCP = false;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  systemd = {
    network = {
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
    services = {
      "systemd-networkd" = {
        environment = {
          SYSTEMD_LOG_LEVEL = "debug";
        };
      };
    };
  };
}
