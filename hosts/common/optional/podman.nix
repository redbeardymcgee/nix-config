{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
  ];

  virtualisation = {
    oci-containers = {
      backend = "podman";
    };

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
