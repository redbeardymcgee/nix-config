{config, ...}: {
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };
  };
}
