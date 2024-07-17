{pkgs, ...}: {
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";

      y = {
        body =
          /*
          fish
          */
          ''
            set tmp (mktemp -p $XDG_RUNTIME_DIR yazi-cwd.XXXXXX)
            yazi $argv --cwd-file=$tmp
            if set cwd (command cat -- $tmp); and [ -n $cwd ]; and [ $cwd != $PWD ]
              cd $cwd
            end
          '';
        wraps = "yazi";
      };

      mark_cmd_start = {
        onEvent = "fish_preexec";
        body =
          /*
          fish
          */
          ''echo -en "\e]133;C\e\\"'';
      };

      mark_cmd_end = {
        onEvent = "fish_postexec";
        body =
          /*
          fish
          */
          ''echo -en "\e]133;D\e\\"'';
      };

      mark_prompt_start = {
        onEvent = "fish_prompt";
        body =
          /*
          fish
          */
          ''echo -en "\e]133;A\e\\"'';
      };

      update_cwd_osc = {
        description = ''Notify terminals when $PWD changes'';
        onVariable = "PWD";

        body =
          /*
          fish
          */
          ''
            if status --is-command-substitution || set -q INSIDE_EMACS
                return
            end
            printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
          '';
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
      dps =
        /*
        fish
        */
        ''
          docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
        '';
    };
  };

  home.packages = with pkgs; [
    grc
  ];
}
