{config, ...}: {
  programs.otter-launcher = {
    enable = true;

    settings = {
      general = {
        default_module = "app";
        empty_module = "app";
        exec_cmd = "sh -c";
        vi_mode = true;
        esc_to_abort = true;
        cheatsheet_entry = "?";
        cheatsheet_viewer = "less -R; clear";
        clear_screen_after_execution = false;
        loop_mode = false;
        external_editor = "vim";
        delay_startup = 0;
        # callback = ""
      };

      # ANSI color codes are allowed. However, \x1b should be replaced with \u001B, because the rust toml crate cannot read \x as an escaped character
      interface = {
        header = ''
          \u001B[34;1m$USER@$(printf $HOSTNAME)\u001B[0m     \u001B[31m\u001B[0m $(mpstat | awk 'FNR ==4 {print $4}')
        '';
        header_cmd =
          # bash
          ''
            printf "\n"
            fastfetch \
                --structure colors:break:title:os:shell:kernel:uptime \
                --logo-print-remaining false \
                --logo-height 8 \
                --logo-padding-left 3 \
                --sixel ${config.xdg.configHome}/otter-launcher/images/images_squ/archlinux_chan.jpg
          '';
        header_cmd_trimmed_lines = 0;
        place_holder = "type & search";
        suggestion_mode = "list";
        separator = "                  \u001B[90mmodules ────────────────";
        footer = "";
        suggestion_lines = 3;
        list_prefix = " ";
        selection_prefix = "\u001B[31;1m▌ ";
        prefix_padding = 3;
        default_module_message = "  \u001B[33mLaunch\u001B[0m apps";
        empty_module_message = "";
        customized_list_order = false;
        indicator_with_arg_module = "";
        indicator_no_arg_module = "";
        prefix_color = "\u001B[33m";
        description_color = "\u001B[39m";
        place_holder_color = "\u001B[30m";
        hint_color = "\u001B[30m";
        move_interface_right = 16;
        move_interface_down = 1;
      };

      # overlay is a floating layer that can be printed with stdout and moved around; useful for integrating chafa images
      # overlay = {
      #   # run a command and print stdout on the overlay layer
      #   overlay_cmd =
      #     # bash
      #     ''
      #     '';
      #   overlay_trimmed_lines = 0;
      #   overlay_height = 0;
      #   move_overlay_right = 0;
      #   move_overlay_down = 0;
      # };

      modules = [
        {
          description = "web search";
          prefix = "s";
          cmd =
            # bash
            "xdg-open https://search.mcgee.red/search?q='{}'";
          with_argument = true;
          url_encode = true;
          unbind_proc = true;
        }
        {
          description = "search apps";
          prefix = "app";
          cmd =
            # bash
            ''
              fsel -vv -d -r -ss "{}"
            '';
          with_argument = true;
        }
        {
          description = "launch apps";
          prefix = "run";
          cmd =
            # bash
            ''
              fsel -vv -d -r -p "{}"
            '';
          with_argument = true;
        }
        {
          description = "power menu";
          prefix = "power";
          cmd =
            # bash
            ''
              function power {
                if [[ -n $1 ]]; then
                case $1 in
                "logout") session=$(loginctl session-status | head -n 1 | awk '{print $1}'); loginctl terminate-session $session ;;
                "suspend") systemctl suspend ;;
                "hibernate") systemctl hibernate ;;
                "reboot") systemctl reboot ;;
                "shutdown") systemctl poweroff ;;
                esac fi
              }
              power $(echo -e 'reboot\nshutdown\nlogout\nsuspend\nhibernate' | fzf --padding 1,2 --info-command 'printf " power menu ($FZF_POS/$FZF_TOTAL_COUNT)"' --cycle --gutter " " --pointer " ▌" --color "bg+:-1,pointer:1,info:8,separator:8,scrollbar:0" --prompt '  ' | tail -1)
            '';
        }

        {
          description = "run commands";
          prefix = "sh";
          cmd =
            # bash
            ''
              $(printf $TERM | sed 's/xterm-//g') -e sh -c "{}"
            '';
          with_argument = true;
          unbind_proc = true;
        }
        {
          description = "open dirs (yazi)";
          prefix = "yz";
          cmd =
            # bash
            ''
              find ${config.home.homeDirectory} -type d -not -path '*/.cache/*' 2>/dev/null | fzf --padding 1,3 --info-command 'printf " directories ($FZF_POS/$FZF_TOTAL_COUNT)"' --cycle --gutter ' ' --pointer ' ▌' --color 'bg+:-1,pointer:1,info:8,separator:8,scrollbar:0' --prompt '  ' | xargs -r -I [] setsid -f "$(echo $TERM | sed 's/xterm-//g')" -e yazi '[]'
            '';
        }
      ];
    };
  };
}
