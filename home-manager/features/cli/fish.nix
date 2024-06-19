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
    };
    shellAliases = {
      dps = ''
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
      '';
    };
  };
}
