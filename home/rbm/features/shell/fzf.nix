{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'bat -n --color always --file-name {} {}'"
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
