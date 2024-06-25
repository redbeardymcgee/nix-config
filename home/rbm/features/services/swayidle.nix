{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.swaylock}";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
        resumeCommand = "${pkgs.swaylock}";
      }
    ];
    extraArgs = [ "-w" ];
  };
}
