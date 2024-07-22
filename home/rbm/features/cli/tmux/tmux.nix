{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;

    # TODO: fetch plugins directly
    extraConfig = ''
      set -g allow-passthrough on
      set -g status-position 'top'

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
      set -g @plugin 'jaclu/tmux-power-zoom'
      set -g @plugin 'niqodea/tmux-matryoshka'
      set -g @plugin 'lljbash/tmux-update-display'

      set -g @plugin 'rickstaa/tmux-notify'
      set -g @tnotify-prompt-suffixes '◉'
      set -g @tnotify-verbose 'on'

      set -g @plugin 'omerxx/tmux-sessionx'
      set -g @sessionx-additional-options '--tmux center'
      set -g @sessionx-tree-mode 'on'
      set -g @sessionx-zoxide-mode 'on'

      set -g @plugin 'omerxx/tmux-floax'
      set -g @floax-bind 'C-/'
      set -g @floax-bind-menu 'Space'

      set -g @plugin 'tmux-plugins/tpm'
      if "test ! -d ~/.config/tmux/plugins/tpm" \
        "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"
      run '~/.config/tmux/plugins/tpm/tpm'

      bind -n M-C source-file '~/.config/tmux/tmux.conf; display-message "Refreshed config!"'
      bind r respawn-pane
      bind R respawn-window
    '';

    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      copy-toolkit
      mode-indicator
      {
        plugin = tilish;
        extraConfig = ''
          set -g @plugin 'sunaku/tmux-navigate'
          set -g @tilish-navigate 'on'
          set -g @tilish-dmenu 'on'
        '';
      }
      yank
    ];

    prefix = "C-a";
    terminal = "tmux-256color";
    tmuxp.enable = true;
  };
}
