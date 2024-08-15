{
  config,
  pkgs,
  ...
}: {
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    # FIXME:
    # Upstream nixpkgs problem causing infinite build duration
    # Waited over 10 minutes
    home = /mnt/2tb;
    openRPCPort = true;
    webHome = pkgs.flood-for-transmission;
    downloadDirPermissions = "755";
    settings = {
      download-dir = "${config.services.transmission.home}/torrents";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,10.0.0.1";
      watch-dir-enabled = true;
      incomplete-dir-enabled = true;
      umask = 18;
    };
  };
}
