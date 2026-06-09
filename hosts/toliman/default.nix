{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./davinci.nix

    ../common/global

    # ../common/optional/apps/adb.nix
    ../common/optional/hardware/dygma.nix
    # ../common/optional/gaming/gamemode.nix
    # ../common/optional/hardware/kmscon.nix
    ../common/optional/dev/nixpkgs.nix
    ../common/optional/dev/podman.nix
    ../common/optional/networking/protonvpn.nix
    ../common/optional/hardware/qmk.nix
    ../common/optional/boot/quietboot.nix
    ../common/optional/gaming/steam.nix
    ../common/optional/apps/stylix.nix
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/networking/systemd-networkd.nix
    ../common/optional/networking/wireshark.nix
    ../common/optional/networking/firewall.nix
    ../common/optional/hardware/razer.nix

    ../common/greeters/dms-greeter.nix
    # ../common/greeters/regreet.nix
    ../common/services/keyring.nix
    ../common/services/udisks2.nix
    ../common/services/jellyfin.nix
    ../common/services/localsend.nix
    ../common/services/polkit.nix
    ./sunshine.nix
    # ../common/services/wormhole.nix

    ../common/users
  ];

  programs.nix-ld.enable = true;

  # security.pam.services.swaylock = {
  #   enable = true;
  #   text = "auth include login";
  # };

  ## TODO: `river-classic` is 0.3.x branch
  services.displayManager.sessionPackages = [pkgs.niri pkgs.river-classic];
  # services.displayManager.sessionPackages = [pkgs.river];

  environment.systemPackages = [pkgs.lact];
  services.lact = {
    enable = true;
  };

  hardware = {
    amdgpu = {
      opencl.enable = true;
      overdrive.enable = true;
      initrd.enable = true;
    };
  };

  networking = {
    domain = "home";
    hostName = "toliman";
  };
}
