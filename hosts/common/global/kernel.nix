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

    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };
}
