{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    ./hardware-configuration.nix

    ../common/global
    ../common/users
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 60;
        consoleMode = "auto";
        editor = true;
        memtest86.enable = true;
      };
    };
    plymouth = {
      enable = false;
    };
  };

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
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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
    networkmanager.enable = true;
  };

  users.mutableUsers = false;
}
