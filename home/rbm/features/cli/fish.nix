{
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";
      yy = {
        body = ''
          set tmp (mktemp -p $XDG_RUNTIME_DIR yazi-cwd.XXXXXX)
          yazi $argv --cwd-file=$tmp
          if set cwd (cat -- $tmp); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd "$cwd"
          end
        '';
        wraps = "yazi";
      };
    };

    shellAbbrs = rec {
        gp = "gtrash put";
        rm = "gtrash put";

        "--help" = {
          position = "anywhere";
          expansion = "--help 2>&1 | bathelp";
        };

        hm = "home-manager --flake .";
        hms = "home-manager switch --flake .";
        snr = "sudo nixos-rebuild --flake .";
        snrs = "sudo nixos-rebuild switch --flake .";

        vim = "nvim";
        vi = vim;
        v = vim;
    };

    shellAliases = rec {
      bathelp = "bat --plain --language=help";

      dps = ''
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
      '';

    };
  };
}
