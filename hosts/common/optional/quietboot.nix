{pkgs, ...}: {
  console = {
    earlySetup = true;
    font = "ter-u12n";
    packages = with pkgs; [terminus_font];
    useXkbConfig = true;
  };

  boot = {
    # plymouth = {
    #   enable = false;
    #
    #   theme = "pixels";
    #   themePackages = with pkgs; [
    #     (adi1090x-plymouth-themes.override {
    #       selected_themes = ["pixels"];
    #     })
    #   ];
    # };

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
      # systemd = {
      #   enable = true;
      #
      #   units = {
      #     activate-numlock = {
      #       name = "activate-numlock.service";
      #       text = ''
      #         [Unit]
      #         Description=Activate numlock before login
      #
      #         [Service]
      #         ExecStart=${pkgs.kbd}/bin/setleds +num
      #
      #         [Install]
      #         WantedBy=multi-user.target
      #       '';
      #     };
      #   };
      # };

      kernelModules = ["nvidia"];
      verbose = false;
    };
  };
}
