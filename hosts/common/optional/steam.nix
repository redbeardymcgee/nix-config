{pkgs, ...}: {
  # hardware.steam-hardware.enable = true;
  programs.java.enable = true;

  programs.steam = {
    enable = true;

    extraPackages = with pkgs; [
      gamescope
    ];

    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extest.enable = true;
  };
}
