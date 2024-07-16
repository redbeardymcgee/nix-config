{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 60;
        consoleMode = "auto";
        editor = true;
        # memtest86.enable = true;
      };
    };
  };
}
