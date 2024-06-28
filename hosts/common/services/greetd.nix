{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          /*
          sh
          */
          ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              --asterisks \
              --cmd ${pkgs.river}/bin/river \
              --remember \
              --remember-user-session \
              --theme "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red" \
              --time \
              --user-menu \
              --debug
          '';
        user = "greeter";
      };
    };
  };
}
