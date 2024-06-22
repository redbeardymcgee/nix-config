{ pkgs, ... }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --asterisks \
            --cmd ${pkgs.river}/bin/river \
            --remember \
            --remember-user-session 
            --time \
            --user-menu
          '';
          user = "greeter";
        };
      };
    };

  }
