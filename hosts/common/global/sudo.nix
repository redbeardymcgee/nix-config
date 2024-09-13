{pkgs, ...}: {
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraRules = [
      {
        users = ["rbm"];
        commands = [
          {
            command = "${pkgs.systemd}/bin/systemctl suspend";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.protonvpn-cli_2}/bin/protonvpn connect --sc";
            options = ["NOPASSWD"];
          }
        ];
        # groups = ["wheel"];
      }
    ];
  };
}
