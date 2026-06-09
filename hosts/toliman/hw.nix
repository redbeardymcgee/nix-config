{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = ["kvm-amd"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bd6f7cd5-fc6a-43e3-9cd2-150558c92a02";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DD7C-2B63";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    "/2tb" = {
      device = "/dev/disk/by-uuid/0b8b0c5d-8363-43a5-8a3a-a71fa3c7d953";
      fsType = "ext4";
      mountPoint = "/mnt/2tb";
      options = [
        "users"
        "exec"
        "nofail"
      ];
    };
  };

  networking.interfaces = {
    enp191s0.useDHCP = lib.mkDefault true;
    wlp192s0.useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
