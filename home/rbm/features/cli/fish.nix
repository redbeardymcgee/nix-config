{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";
      # shellInitLast = "update_cwd_osc";
      #
      # mark_cmd_start = {
      #   onEvent = "fish_preexec";
      #   body =
      #     # fish
      #     ''
      #       echo -en "\e]133;C\e\\"
      #     '';
      # };
      #
      # mark_cmd_end = {
      #   onEvent = "fish_postexec";
      #   body =
      #     # fish
      #     ''
      #       echo -en "\e]133;D\e\\"
      #     '';
      # };
      #
      # mark_prompt_start = {
      #   onEvent = "fish_prompt";
      #   body =
      #     # fish
      #     ''
      #       echo -en "\e]133;A\e\\"
      #     '';
      # };
      #
      # update_cwd_osc = {
      #   description = "Notify terminals when $PWD changes";
      #   onVariable = "PWD";
      #
      #   body =
      #     # fish
      #     ''
      #       if status --is-command-substitution || set -q INSIDE_EMACS
      #           return
      #       end
      #       printf \e\]7\;file://%s%s\e\\ "$hostname" "$(string escape --style=url "$PWD")"
      #     '';
      # };
    };

    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    shellAbbrs = rec {
      gp = "gtrash put";
      rm = "gtrash put";

      nhb = "nh home build";
      nhs = "nh home switch";
      nob = "nh os build";
      nos = "nh os switch";
      hm = "home-manager --flake .";
      hmb = "home-manager --flake . build";
      hms = "home-manager --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";

      vim = "redvim";
      vi = vim;
      v = vim;

      "--help" = {
        position = "anywhere";
        expansion = "--help 2>&1 | bathelp";
      };
    };

    shellAliases = let
      shellPipeline = commands: lib.strings.concatStringsSep " | " commands;
    in {
      nm = shellPipeline [
        "manix ''"
        "grep '^# ' "
        "sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' "
        ''fzf --preview="manix '{}'" ''
        "xargs manix"
      ];
    };
  };
}
