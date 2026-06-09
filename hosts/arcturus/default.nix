{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./nvidia.nix
    ./intel.nix

    ../common/global

    ../common/optional/apps/adb.nix
    ../common/optional/hardware/dygma.nix
    ../common/optional/gaming/gamemode.nix
    ../common/optional/hardware/kmscon.nix
    ../common/optional/dev/podman.nix
    ../common/optional/boot/quietboot.nix
    # ../common/optional/gaming/steam.nix
    ../common/optional/apps/stylix.nix
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/networking/systemd-networkd.nix
    ../common/optional/networking/wireshark.nix
    ../common/optional/networking/firewall.nix

    # ../common/greeters/ly.nix
    # ../common/greeters/greetd.nix
    # ../common/greeters/regreet.nix
    ../common/greeters/dms-greeter.nix
    ../common/services/keyring.nix
    ../common/services/udisks2.nix
    ../common/services/jellyfin.nix
    ../common/services/polkit.nix
    # ../common/services/sunshine.nix
    # ../common/services/wormhole.nix

    ../common/users
  ];

  # security.pam.services.swaylock = {
  #   enable = true;
  #   text = "auth include login";
  # };
  services.displayManager.sessionPackages = [pkgs.niri pkgs.river];

  networking = {
    domain = "home";
    hostName = "arcturus";
  };
}
