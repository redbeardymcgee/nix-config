{
  config,
  lib,
  ...
}: let
  nvidia555 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "555.58.02";
    sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    persistencedSha256 = lib.fakeSha256;
  };
  nvidia570 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.169";
    sha256_64bit = "sha256-XzKoR3lcxcP5gPeRiausBw2RSB1702AcAsKCndOHN2U=";
    sha256_aarch64 = "sha256-s8jqaZPcMYo18N2RDu8zwMThxPShxz/BL+cUsJnszts=";
    openSha256 = "sha256-oqY/O5fda+CVCXGVW2bX7LOa8jHJOQPO6mZ/EyleWCU=";
    settingsSha256 = "sha256-0E3UnpMukGMWcX8td6dqmpakaVbj4OhhKXgmqz77XZc=";
    persistencedSha256 = "sha256-dttFu+TmbFI+mt1MbbmJcUnc1KIJ20eHZDR7YzfWmgE=";
  };
in {
  services.xserver.videoDrivers = ["nvidia"];

  boot = {
    # kernelParams = ["module_blacklist=i915"];
    # initrd.kernelModules = ["nvidia"];
    # extraModulePackages = [nvidia555];
  };

  hardware = {
    # nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # package = nvidia555;
      package = nvidia570;
      open = false;
      modesetting.enable = true;
      nvidiaSettings = false;
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
  # home.file = {
  #   ".nv/nvidia-application-profiles-rc".text = ''
  #     {
  #         "rules": [
  #             {
  #                 "pattern": {
  #                     "feature": "dso",
  #                     "matches": "libGL.so.1"
  #                 },
  #                 "profile": "openGL_fix"
  #             }
  #         ],
  #         "profiles": [
  #             {
  #                 "name": "openGL_fix",
  #                 "settings": [
  #                     {
  #                         "key": "GLThreadedOptimizations",
  #                         "value": false
  #                     }
  #                 ]
  #             }
  #         ]
  #     }
  #   '';
  # };
}
