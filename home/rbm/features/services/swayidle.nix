{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    # FIXME: can't unlock, just ignores password
    # events = [
    #   {
    #     event = "before-sleep";
    #     command = "${pkgs.swaylock}/bin/swaylock";
    #   }
    # ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
