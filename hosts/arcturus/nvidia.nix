{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = false;
      prime.offload.enable = false;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };
}
