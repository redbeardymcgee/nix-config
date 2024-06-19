{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'head {}'"
    ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
    tmux = {
      enableShellIntegration = true;
    };
  };
}
