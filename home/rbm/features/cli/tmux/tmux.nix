{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    python312Packages.libtmux
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "M-Space";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; let
      tmux-nerd-font-window-name = mkTmuxPlugin {
        pluginName = "nerd-font-window-name";
        rtpFilePath = "tmux-nerd-font-window-name.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "joshmedeski";
          repo = "tmux-nerd-font-window-name";
          rev = "9a66e18972de25c0bb3a58b7422d6e6555f166ba";
          hash = "sha256-X4Li6xkxKjqac7xedCNzzSoW7wT6N2oqVKIx7TFay64=";
        };
      };

      tmux-power-zoom = mkTmuxPlugin {
        pluginName = "power-zoom";
        rtpFilePath = "power-zoom.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "jaclu";
          repo = "tmux-power-zoom";
          rev = "5916f2087c140e9fbac7f3bbf64765581646c042";
          hash = "sha256-3RI/waUjmAoqRrihjenDSq777kf3sLXaWWYJMCRlEvQ=";
        };
      };

      tmux-matryoshka = mkTmuxPlugin {
        pluginName = "matryoshka";
        rtpFilePath = "matryoshka.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "niqodea";
          repo = "tmux-matryoshka";
          rev = "2865a5913e0884b2bdd731b610e39d125c281979";
          hash = "sha256-r1p8soVcG+GFvacubr3R7eHqzaUwSfbvgvWFeYXntZQ=";
        };
      };

      tmux-fzf-links = mkTmuxPlugin {
        pluginName = "fzf-links";
        rtpFilePath = "fzf-links.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "alberti42";
          repo = "tmux-fzf-links";
          rev = "3c4b7acb4b94d2bb8791a3b0b5798d740238216d";
          hash = "sha256-Ems/tvPQiQaTMHfeshED1tIJyeZC2+4KTQTlhZJXAuI=";
        };
      };

      tmux-menus = mkTmuxPlugin {
        pluginName = "menus";
        rtpFilePath = "menus.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "jaclu";
          repo = "tmux-menus";
          rev = "879f56df1b9703ac277fa16b9bbaf8705f2e6a1c";
          hash = "sha256-UPWsa7sFy6P3Jo3KFEvZrz4M4IVDhKI7T1LNAtWqTT4=";
        };
      };

      tmux-smart-splits = mkTmuxPlugin {
        pluginName = "smart-splits";
        rtpFilePath = "smart-splits.tmux";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "mrjones2014";
          repo = "smart-splits.nvim";
          rev = "076426b93a0654b6e1467258514dd9021a5e33e2";
          hash = "sha256-3khwZo1/R3DGmwzy/sAoch6uZuEnkOL7XMogWfgzmoc";
        };
      };
    in [
      extrakto
      mode-indicator
      tmux-nerd-font-window-name
      tmux-power-zoom
      tmux-matryoshka
      yank

      {
        plugin = tmux-smart-splits;
        extraConfig =
          # tmux
          ''
            set -g @smart-splits_move_left_key  'M-h'
            set -g @smart-splits_move_down_key  'M-j'
            set -g @smart-splits_move_up_key    'M-k'
            set -g @smart-splits_move_right_key 'M-l'

            set -g @smart-splits_resize_left_key  'M-H'
            set -g @smart-splits_resize_down_key  'M-J'
            set -g @smart-splits_resize_up_key    'M-K'
            set -g @smart-splits_resize_right_key 'M-L'
          '';
      }

      {
        plugin = tmux-fzf-links;
        extraConfig =
          # tmux
          ''
            set -g '@fzf-links-key' u
            set -g '@fzf-links-editor-open-cmd' "tmux popup -E -w 80% -h 80% nvim +%line '%file'"
            set -g '@fzf-links-browser-open-cmd' "xdg-open '%url'"
            set -g '@fzf-links-python' "${lib.getExe pkgs.python3}"
          '';
      }

      {
        plugin = tmux-menus;
        extraConfig =
          # tmux
          ''
            set -g @menus_trigger 'Space'
          '';
      }

      {
        ## TODO: https://github.com/2KAbhishek/tmux-tilit
        plugin = tilish;
        extraConfig =
          # tmux
          ''
            # set -g @tilish-smartsplits 'on'
            # set -g @tilish-default 'main-vertical'
          '';
      }
    ];

    # TODO: fetch plugins directly as flake inputs
    extraConfig =
      # tmux
      ''
        set -g allow-passthrough on
        set -g status-position top

        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        set -g popup-border-lines rounded
        set -g popup-style "bg=#24273a,fg=#cad3f5"
        set -g popup-border-style "bg=#24273a,fg=#00bbff"

        set -g display-time 4000
        set -g status-interval 5

        set -g detach-on-destroy off

        # set -g @plugin 'tmux-plugins/tpm'
        # if "test ! -d ~/.config/tmux/plugins/tpm" \
        #   "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"
        # run '~/.config/tmux/plugins/tpm/tpm'

        unbind Space

        bind -n M-C 'source-file ~/.config/tmux/tmux.conf; display-message "Refreshed config!"'
        bind r respawn-pane
        bind R respawn-window

        bind-key -T root KPEnter send-keys Escape O M
      '';
  };
}
