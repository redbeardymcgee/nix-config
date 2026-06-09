{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./davinci.nix

    ../common/global

    # ../common/optional/adb.nix
    ../common/optional/dygma.nix
    # ../common/optional/gamemode.nix
    # ../common/optional/kmscon.nix
    ../common/optional/nixpkgs.nix
    ../common/optional/podman.nix
    ../common/optional/protonvpn.nix
    ../common/optional/qmk.nix
    ../common/optional/quietboot.nix
    ../common/optional/steam.nix
    ../common/optional/stylix.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/systemd-networkd.nix
    ../common/optional/wireshark.nix
    ../common/optional/firewall.nix
    ../common/optional/razer.nix

    ../common/services/dms-greeter.nix
    # ../common/services/regreet.nix
    ../common/services/keyring.nix
    ../common/services/udisks2.nix
    ../common/services/jellyfin.nix
    ../common/services/localsend.nix
    ../common/services/polkit.nix
    ../common/services/sunshine.nix
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
