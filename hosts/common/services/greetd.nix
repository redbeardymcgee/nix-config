{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          # sh
          ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              --asterisks \
              --cmd river \
              --remember \
              --remember-user-session \
              --time \
              --user-menu \
              --power-shutdown 'sudo systemctl poweroff' \
              --power-reboot 'sudo systemctl reboot' \
              --debug
          '';
        user = "greeter";
      };
    };
  };
}
