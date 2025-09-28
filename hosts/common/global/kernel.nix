{
  config,
  lib,
  pkgs,
  ...
}: {
  boot = {
    blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
      "ath3k"
    ];

    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
  };
}
