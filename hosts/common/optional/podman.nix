{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podlet
  ];

  virtualisation = {
    oci-containers = {
      backend = "podman";
    };

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = false;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
