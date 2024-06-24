{ pkgs, ... }: {
    security.sudo = {
      enable = true;
      execWheelOnly = true;
      extraRules = [
        {
          users = [ "rbm" ];
          commands = [
            { command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
          ];
        }
      ];
    };
  }
