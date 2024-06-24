{
  config,
  ...
}: {
  boot.extraModulePackages = [config.boot.kernelPackages.wireguard];
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        # See also man systemd.netdev (also contains info on the permissions of the key files)
        wireguardConfig = {
          # Don't use a file from the Nix store as these are world readable. Must be readable by the systemd.network user
          PrivateKeyFile = "/run/keys/wireguard-privkey";
          ListenPort = 9918;
        };
        wireguardPeers = [          
          # configuration since nixos-unstable/nixos-24.11
          {
            PublicKey = "OhApdFoOYnKesRVpnYRqwk3pdM247j8PPVH5K7aIKX0=";
            AllowedIPs = ["fc00::1/64" "10.100.0.1"];
            Endpoint = "{set this to the server ip}:51820";
          }
          # configuration for nixos 24.05
          #{
          #  wireguardPeerConfig = {
          #    PublicKey = "OhApdFoOYnKesRVpnYRqwk3pdM247j8PPVH5K7aIKX0=";
          #    AllowedIPs = ["fc00::1/64" "10.100.0.1"];
          #    Endpoint = "{set this to the server ip}:51820";
          #  };
          #}
        ];
      };
    };
    networks.wg0 = {
      # See also man systemd.network
      matchConfig.Name = "wg0";
      # IP addresses the client interface will have
      address = [
        "fe80::3/64"
        "fc00::3/120"
        "10.100.0.2/24"
      ];
      DHCP = "no";
      dns = ["fc00::53"];
      ntp = ["fc00::123"];
      gateway = [
        "fc00::1"
        "10.100.0.1"
      ];
      networkConfig = {
        IPv6AcceptRA = false;
      };
    };
  };
}
