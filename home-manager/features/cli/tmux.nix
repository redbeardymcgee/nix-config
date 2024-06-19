{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set -g @plugin 'b0o/tmux-autoreload'
      set -g @plugin 'sunaku/tmux-navigate'
      set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'

      set -g @plugin 'rickstaa/tmux-notify'
      set -g @tnotify-prompt-suffixes '◉'
      set -g @tnotify-verbose 'on'

      set -g @plugin 'jaclu/tmux-power-zoom'

      set -g @plugin 'omerxx/tmux-sessionx'

      set -g @sessionx-additional-options '--tmux center'
      set -g @sessionx-tree-mode 'on'
      set -g @sessionx-window-mode 'on'
      set -g @sessionx-zoxide-mode 'on'

      set -g status-position 'top'

      set -g @plugin 'tmux-plugins/tpm'
      if "test ! -d ~/.config/tmux/plugins/tpm" \
        "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"
      run '~/.config/tmux/plugins/tpm/tpm'
    '';
    historyLimit = 10000;
    mouse = true;
    newSession = true;
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
          set -g @tilish-dmenu 'on'
        '';
      }
      yank
    ];
    prefix = "C-a";
    terminal = "tmux-256color";
  };
}
