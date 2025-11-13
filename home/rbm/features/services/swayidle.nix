{pkgs, ...}: {
  services.swayidle = {
    enable = false;
    # FIXME: can't unlock, just ignores password
    # events = [
    #   {
    #     event = "before-sleep";
    #     command = "${pkgs.swaylock}/bin/swaylock";
    #   }
    # ];
    timeouts = [
      {
        timeout = 3600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
