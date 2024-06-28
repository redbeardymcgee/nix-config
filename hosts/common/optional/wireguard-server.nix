{...}: {
  networking.firewall.allowedUDPPorts = [51820];
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    netdevs = {
      "50-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        wireguardConfig = {
          PrivateKeyFile = "/run/keys/wireguard-privkey";
          ListenPort = 51820;
        };
        wireguardPeers = [
          # configuration since nixos-unstable/nixos-24.11
          {
            PublicKey = "L4msD0mEG2ctKDtaMJW2y3cs1fT2LBRVV7iVlWZ2nZc=";
            AllowedIPs = ["10.100.0.2"];
          }
          # configuration for nixos 24.05
          #{
          #  wireguardPeerConfig = {
          #    PublicKey = "L4msD0mEG2ctKDtaMJW2y3cs1fT2LBRVV7iVlWZ2nZc=";
          #    AllowedIPs = ["10.100.0.2"];
          #  };
          #}
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = ["10.100.0.1/24"];
      networkConfig = {
        IPMasquerade = "ipv4";
        IPForward = true;
      };
    };
  };
}
