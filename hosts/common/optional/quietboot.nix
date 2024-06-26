{
  pkgs,
  ...
}: {
  console = {
    earlySetup = true;
    font = "ter-u14n";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true;
  };

  boot = {
    plymouth = {
      enable = true;
      theme = "pixels";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "pixels" ];
        })
      ];
    };
    loader.timeout = 0;
    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "splash"
    ];
    consoleLogLevel = 0;
    initrd = {
      preLVMCommands = "${pkgs.kbd}/bin/setleds +num";
      kernelModules = [ "nvidia" ];
      verbose = false;
    };
  };
}
