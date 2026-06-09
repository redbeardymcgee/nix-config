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
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = ["kvm-intel"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/84d68c5a-e721-4053-b45e-5470c336e793";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/94D7-0C24";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
