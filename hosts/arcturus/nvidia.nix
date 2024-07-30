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

      # extraPackages = with pkgs; [
      #   intel-media-driver
      #   vaapiIntel
      #   vaapiVdpau
      #   libvdpau-va-gl
      # ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = false;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };
}
