{pkgs, ...}: {
  # hardware.steam-hardware.enable = true;
  programs.java.enable = true;

  programs.steam = {
    enable = true;

    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
