{
  programs.zk = {
    enable = true;
    settings = {
      alias = {
        last = "zk edit --limit 1 --sort modified- $@";
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
        lucky = "zk list --quiet --format full --sort random --limit 1";
      };
      extra.author = "rbm";
      lsp = {
        diagnostics = {
          wiki-title = "hint";
          dead-link = "error";
        };
        completion = {
          note-label = "{{title-or-path}}";
          note-filter-text = "{{title}} {{path}}";
          note-detail = "{{filename-stem}}";
        };
      };
      notebook.dir = "~/Documents/Notebook";
      note = {
        default-title = "Untitled";
        filename = "{{id}}-{{slug title}}";
        extension = "md";
      };
      tool = {
        fzf-preview = "bat -p --color always {-1}";
      };
      filter = {
        recents = "--sort created- --created-after 'last two weeks'";
      };
      format.markdown = {
        hashtags = true;
        colon-tags = true;
      };
    };
  };
}
