{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        timeout = 600;
        command = "${pkgs.chayang}/bin/chayang && ${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
