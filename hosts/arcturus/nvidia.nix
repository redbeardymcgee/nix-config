{config, ...}: {
  boot = {
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;

      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
  };
}
