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
}
