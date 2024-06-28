{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    # events = {
    #   event = "after-resume";
    #   command = "${pkgs.swaylock}/bin/swaylock";
    # };
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
