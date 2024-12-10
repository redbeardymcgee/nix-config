{
  networking = {
    nameservers = [
      "192.168.1.1"
      "1.1.1.1"
      "1.0.0.1"
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
      "1.1.1.1"
      "1.0.0.1"
      # "2001:4860:4860::8844"
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
        matchConfig.Name = "enp0s31f6";
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
        };
      };
    };
  };
}
