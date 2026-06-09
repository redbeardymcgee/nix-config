{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./intel.nix

    ../common/global

    ../common/optional/adb.nix
    ../common/optional/dygma.nix
    ../common/optional/gamemode.nix
    ../common/optional/kmscon.nix
    ../common/optional/podman.nix
    ../common/optional/quietboot.nix
    # ../common/optional/steam.nix
    ../common/optional/stylix.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/systemd-networkd.nix
    ../common/optional/wireshark.nix
    ../common/optional/firewall.nix

    # ../common/services/ly.nix
    # ../common/services/greetd.nix
    ../common/services/regreet.nix
    ../common/services/keyring.nix
    ../common/services/udisks2.nix
    ../common/services/jellyfin.nix
    ../common/services/polkit.nix
    # ../common/services/sunshine.nix
    # ../common/services/wormhole.nix

    ../common/users
  ];

  networking = {
    domain = "home";
    hostName = "luhman";
  };
}
