{config, ...}: let
  nvidia555 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "555.58.02";
    sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
    openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
    settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
  };
in {
  services.xserver.videoDrivers = ["nvidia"];

  boot = {
    # kernelParams = ["module_blacklist=i915"];
    initrd.kernelModules = ["nvidia"];
    extraModulePackages = [nvidia555];
  };

  hardware = {
    nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.production;
      package = nvidia555;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      prime = {
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };
        # sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:0:0";
      };
    };
  };
}
