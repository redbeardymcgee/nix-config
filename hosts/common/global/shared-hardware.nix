{pkgs, ...}: {
  hardware = {
    enableRedistributableFirmware = true;
    xpadneo.enable = true;
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  fileSystems = {
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
}
