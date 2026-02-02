{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  boot = {
    blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
      "ath3k"
    ];

    kernelPackages = pkgs-unstable.linuxKernel.packages.linux_xanmod_latest;
  };
}
