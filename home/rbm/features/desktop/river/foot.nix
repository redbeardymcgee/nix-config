{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "yes";
        font = "FiraCode Nerd Font:size=10";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      key-bindings = {
        pipe-command-output = ''
          [sh -c 'f=$(mktemp); cat - > $f; footclient bat $f; rm $f'] Control+Shift+g
        '';
      };
    };
  };

  programs.fish = {
    functions = {
      foot_cmd_start = {
        body = ''echo -en "\e]133;C\e\\"'';
        onEvent = "fish_preexec";
      };
      foot_cmd_end = {
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
    };
    shellInitLast = "update_cwd_osc";
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super Space" = "spawn 'foot tmuxp load -y localhost'";
    };
  };
}
