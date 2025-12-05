{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hw.nix
    ./davinci.nix

    ../common/global

    ../common/optional/adb.nix
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

    ../common/services/regreet.nix
    ../common/services/keyring.nix
    ../common/services/udisks2.nix
    ../common/services/jellyfin.nix
    ../common/services/localsend.nix
    ../common/services/polkit.nix
    ../common/services/sunshine.nix
    # ../common/services/wormhole.nix

    ../common/users
  ];

  # security.pam.services.swaylock = {
  #   enable = true;
  #   text = "auth include login";
  # };

  ## TODO: `river-classic` is 0.3.x branch in 25.11
  services.displayManager.sessionPackages = [pkgs.river-classic];
  # services.displayManager.sessionPackages = [pkgs.river];

  environment.systemPackages = [pkgs.lact];
  services.lact = {
    enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    amdgpu = {
      opencl.enable = true;
      overdrive.enable = true;
      initrd.enable = true;
    };
    # xone.enable = true;
    xpadneo.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  networking = {
    domain = "home";
    hostName = "toliman";
  };

  services.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;

    configFile = pkgs.writeText "default.pa" ''
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
    '';

    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };
}
