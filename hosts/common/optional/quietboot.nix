{pkgs, ...}: {
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    useXkbConfig = true;
  };

  boot = {
    consoleLogLevel = 0;
    loader.timeout = 0;

    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "splash"
    ];

    plymouth = {
      enable = false;

      theme = "pixels";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["pixels"];
        })
      ];
    };
  };
}
