{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
          sha256 = "sha256-uWdoKLc36PuOqlGYMD01016N8BlVC+FTyKQsma/gzdU=";
        };
        version = "6.6.36";
        modDirVersion = "6.6.36";
      };
    });
  };
}
