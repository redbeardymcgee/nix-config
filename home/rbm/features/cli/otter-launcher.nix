{
  lib,
  pkgs,
  ...
}: {
  programs.otter-launcher = {
    enable = true;

    settings = {
      general = {
        default_module = "app";
        empty_module = "app";
        exec_cmd = "bash -c";
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

      interface = let
        mpstat = "${lib.getBin pkgs.sysstat}/bin/mpstat";

        # NOTE: `ansi --escape-style unicode $color`
        s = str: builtins.fromJSON ''"${str}"'';
        red = s ''\u001b[31m'';
        green = s ''\u001b[32m'';
        yellow = s ''\u001b[33m'';
        blue = s ''\u001B[34m'';
        magenta = s ''\u001b[35m'';
        white = s ''\u001b[37m'';
        gray = s ''\u001b[90m'';
        cyan = s ''\u001b[36m'';
        dimmed = s ''\u001b[2m'';
        reset = s ''\u001b[0m'';
      in {
        ## NOTE: Goes on top of header & prompt
        # header_cmd =
        #   # bash
        #   ''
        #     fastfetch
        #   '';
        header =
          # bash
          ''
            ${blue}$USER${yellow}@${green}$(printf $HOSTNAME)${reset}     ${red} $(${mpstat} | awk 'FNR ==4 {print $4}')${reset}
          '';
        header_cmd_trimmed_lines = 0;
        place_holder = "type & search";
        place_holder_color = "${gray}";
        suggestion_mode = "list";
        separator = "                  ${magenta}modules ────────────────${reset}";
        footer = "";
        suggestion_lines = 3;
        list_prefix = "${cyan}${reset} ";
        selection_prefix = "${red}▌${reset} ";
        prefix_padding = 3;
        default_module_message = "  ${yellow}Launch${reset} apps";
        empty_module_message = "";
        customized_list_order = false;
        indicator_with_arg_module = "${yellow}${reset} ";
        indicator_no_arg_module = "";
        prefix_color = "${dimmed}${green}";
        description_color = "${dimmed}${gray}";
        hint_color = "${cyan}";
        move_interface_right = 16;
        move_interface_down = 1;
      };

      modules = [
        {
          description = "web search";
          prefix = "s";
          cmd =
            # bash
            ''
              xdg-open https://search.mcgee.red/search?q="{}"
            '';
          with_argument = true;
          url_encode = true;
          unbind_proc = true;
        }
        {
          description = "launch apps";
          prefix = "app";
          cmd =
            # bash
            ''
              fsel --detach --replace
            '';
        }
        {
          description = "power menu";
          prefix = "power";
          cmd =
            # bash
            ''
              power() {
                if [[ -n $1 ]]
                then
                  case $1 in
                    "logout") session=$(loginctl session-status | head -n 1 | awk '{print $1}'); loginctl terminate-session $session ;;
                    "suspend") systemctl suspend ;;
                    "hibernate") systemctl hibernate ;;
                    "reboot") systemctl reboot ;;
                    "shutdown") systemctl poweroff ;;
                  esac
                fi
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
              ghostty --wait-after-command --class=ghostty.launcher -e "{}"
            '';
          with_argument = true;
          unbind_proc = true;
        }
      ];
    };
  };
}
