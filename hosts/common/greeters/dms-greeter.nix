{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.niri];
    # sessionVariables = {
    #   DMS_RUN_GREETER = 1;
    # };
  };
  programs.niri = {
    enable = true;

    # settings = {
    #   hotkey-overlay.skip-at-startup = true;
    #   environment.DMS_RUN_GREETER = "1";
    #   gestures.hot-corners = "off";
    #   layout.background-color = "#000000";
    # };
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/rbm";
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}
