{pkgs, ...}: {
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

      mark_cmd_start = {
        body = ''echo -en "\e]133;C\e\\"'';
        onEvent = "fish_preexec";
      };

      mark_cmd_end = {
        body = ''echo -en "\e]133;D\e\\"'';
        onEvent = "fish_postexec";
      };

      mark_prompt_start = {
        body = ''echo -en "\e]133;A\e\\"'';
        onEvent = "fish_prompt";
      };

      update_cwd_osc = {
        body = ''
          if status --is-command-substitution || set -q INSIDE_EMACS
              return
          end
          printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
        '';
        description = ''Notify terminals when $PWD changes'';
        onVariable = "PWD";
      };

      shellInitLast = "update_cwd_osc";
    };

    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    shellAbbrs = rec {
      gp = "gtrash put";
      rm = "gtrash put";

      "--help" = {
        position = "anywhere";
        expansion = "--help 2>&1 | bathelp";
      };

      hm = "home-manager --flake .";
      hmb = "home-manager --flake . build";
      hms = "home-manager --flake . switch";
      nhb = "nh home build";
      nhs = "nh home switch";
      nob = "nh os build";
      nos = "nh os switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";

      vim = "nvim";
      vi = vim;
      v = vim;
    };

    shellAliases = {
      dps = ''
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
      '';
    };
  };

  home.packages = with pkgs; [
    grc
  ];
}
