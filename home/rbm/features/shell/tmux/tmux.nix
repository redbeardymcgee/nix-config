{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.tmux-which-key.homeManagerModules.default ];
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
    tmux-which-key = {
      enable = true;
    };

    plugins =
      with pkgs.tmuxPlugins;
      let
        tmux-power-zoom = mkTmuxPlugin {
          pluginName = "power-zoom";
          rtpFilePath = "power-zoom.tmux";
          version = "git";
          src = inputs.tmux-power-zoom;
        };

        tmux-matryoshka = mkTmuxPlugin {
          pluginName = "matryoshka";
          rtpFilePath = "matryoshka.tmux";
          version = "git";
          src = inputs.tmux-matryoshka;
        };

        tmux-fzf-links = mkTmuxPlugin {
          pluginName = "fzf-links";
          rtpFilePath = "fzf-links.tmux";
          version = "git";
          src = inputs.tmux-fzf-links;
        };

        tmux-smart-splits = mkTmuxPlugin {
          pluginName = "smart-splits";
          rtpFilePath = "smart-splits.tmux";
          version = "git";
          src = inputs.tmux-smart-splits;
        };
      in
      [
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

        # {
        #   ## TODO: https://github.com/2KAbhishek/tmux-tilit
        #   plugin = tilish;
        #   extraConfig =
        #     # tmux
        #     ''
        #       # set -g @tilish-smartsplits 'on'
        #       # set -g @tilish-default 'main-vertical'
        #     '';
        # }
      ];

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

        bind -n M-C 'source-file ~/.config/tmux/tmux.conf; display-message "Refreshed config!"'
        bind r respawn-pane
        bind R respawn-window

        bind -n M-1 select-window -t :=1
        bind -n M-2 select-window -t :=2
        bind -n M-3 select-window -t :=3
        bind -n M-4 select-window -t :=4
        bind -n M-5 select-window -t :=5
        bind -n M-6 select-window -t :=6
        bind -n M-7 select-window -t :=7
        bind -n M-8 select-window -t :=8
        bind -n M-9 select-window -t :=9
        bind -n M-0 select-window -t :=10

        bind -n M-n next-window
        bind -n M-p previous-window

        bind -n M-N switch-client -n
        bind -n M-P switch-client -p

        bind-key -T root KPEnter send-keys Escape O M
      '';
  };
}
