{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = let
          args = lib.concatStringsSep " " [
            "--asterisks"
            "--cmd"
            "river"
            "--remember"
            "--remember-user-session"
            "--time"
            "--user-menu"
            "--power-shutdown"
            "'sudo systemctl poweroff'"
            "--power-reboot"
            "'sudo systemctl reboot'"
            "--debug"
          ];
        in
          # sh
          ''${pkgs.greetd.tuigreet}/bin/tuigreet  ${args}}'';
      };
    };
  };
}
