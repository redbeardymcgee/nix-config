{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix

    ../common/global

    ../common/optional/systemd-networkd.nix
    ../common/optional/gamemode.nix
    ../common/optional/kmscon.nix
    ../common/optional/podman.nix
    ../common/optional/quietboot.nix
    ../common/optional/steam-hardware.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/systemd-networkd.nix

    ../common/users
  ];

  fileSystems."/boot".options = [ "umask=0077" ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    pulseaudio = {
      enable = false;
      configFile = pkgs.writeText "default.pa" ''
        load-module module-bluetooth-policy
        load-module module-bluetooth-discover
      '';
      extraConfig = ''
        load-module module-switch-on-connect
      '';
      package = pkgs.pulseaudioFull;
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      prime.offload.enable = false;
    };
  };

  networking = {
    domain = "home.local";
    hostName = "arcturus";
  };

  security.pam.services.swaylock = {};

  users.mutableUsers = false;
}
