{
  networking = {
    nameservers = [
      "192.168.1.1"
      "9.9.9.9"
      "149.112.112.112"
    ];
    useDHCP = false;
  };

  services.resolved = {
    enable = true;
    # dnsovertls = "true";
    # dnssec = "true";
    domains = [
      "~."
      "localdomain"
    ];
    fallbackDns = [
      "9.9.9.9"
      "149.112.112.112"
    ];

    extraConfig = ''
      DNSStubListenerExtra=[::1]:53
    '';
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        linkConfig.RequiredForOnline = "routable";
        # matchConfig.Name = "enp0s31f6";
        matchConfig.Name = "enp191s0";
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
        };
      };
    };
  };
}
