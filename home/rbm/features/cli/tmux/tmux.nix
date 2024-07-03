{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;

    extraConfig =
      /*
      TODO: fetch plugins directly
      */
      ''
        set -g allow-passthrough on
        set -g status-position 'top'

        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        set -g @plugin 'b0o/tmux-autoreload'
        set -g @plugin 'sunaku/tmux-navigate'
        set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
        set -g @plugin 'jaclu/tmux-power-zoom'
        set -g @plugin 'omerxx/tmux-sessionx'
        set -g @plugin 'niqodea/tmux-matryoshka'
        set -g @plugin 'lljbash/tmux-update-display'

        set -g @plugin 'rickstaa/tmux-notify'
        set -g @tnotify-prompt-suffixes '◉'
        set -g @tnotify-verbose 'on'

        set -g @sessionx-additional-options '--tmux center'
        set -g @sessionx-tree-mode 'on'
        set -g @sessionx-zoxide-mode 'on'

        set -g @plugin 'tmux-plugins/tpm'
        if "test ! -d ~/.config/tmux/plugins/tpm" \
          "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"
        run '~/.config/tmux/plugins/tpm/tpm'

        bind -n M-C source-file ~/.config/tmux/tmux.conf
        bind r respawn-pane
        bind R respawn-window
      '';
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
      copy-toolkit
      mode-indicator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-processes 'ssh'
        '';
      }
      {
        plugin = tilish;
        extraConfig = ''
          set -g @plugin 'sunaku/tmux-navigate'
          set -g @tilish-navigate 'on'
        '';
      }
      yank
    ];
    prefix = "C-a";
    terminal = "tmux-256color";
    tmuxp.enable = true;
  };
}
