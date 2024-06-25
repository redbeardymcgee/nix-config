{
  programs.fish = {
    enable = true;
    functions = {
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
    interactiveShellInit = ''
      set -U fish_greeting
    '';
    shellAbbrs = {
        gp = "gtrash put";
        rm = "gtrash put";
        vim = "nvim";
        "-h" = {
          position = "anywhere";
          expansion = "-h 2>&1 | bathelp";
        };
        "--help" = {
          position = "anywhere";
          expansion = "--help 2>&1 | bathelp";
        };
    };
    shellAliases = {
      bathelp = "bat --plain --language=help";
      dps = ''
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
      '';
    };
  };
}
