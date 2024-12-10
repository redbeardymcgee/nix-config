{
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        users = ["rbm"];
        commands = let
          pfx = "/run/current-system/sw/bin";
        in [
          {
            command = "${pfx}/systemctl suspend";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}/reboot";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}poweroff";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}/protonvpn connect -f";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}/bin/nixos-rebuild";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}/nix-collect-garbage";
            options = ["NOPASSWD"];
          }
          {
            command = "${pfx}/nh os switch -u";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
