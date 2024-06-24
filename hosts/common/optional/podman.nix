{config, ...}: let
  dockerEnabled = config.virtualisation.docker.enable;
in {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
