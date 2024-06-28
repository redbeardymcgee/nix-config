{
  programs.zk = {
    enable = true;
    settings = {
      alias = {
        last = "zk edit --limit 1 --sort modified- $@";
        lucky = "zk list --quiet --format full --sort random --limit 1";
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
      };
      extra.author = "rbm";
      filter = {
        recents = "--sort created- --created-after 'last two weeks'";
      };
      format = {
        markdown = {
          link-format = "[[{{filename}}]]";
          colon-tags = true;
          hashtags = true;
        };
      };
      lsp = {
        completion = {
          note-detail = "{{filename-stem}}";
          note-filter-text = "{{title}} {{path}}";
          note-label = "{{title-or-path}}";
        };
        diagnostics = {
          dead-link = "error";
          wiki-title = "hint";
        };
      };
      note = {
        default-title = "untitled";
        extension = "md";
        filename = "{{title}}";
        id-charset = "hex";
        id-length = 8;
        id-case = "lower";
        template = "default.md";
      };
      notebook.dir = "~/Documents/Notebook";
      tool = {
        fzf-preview = "bat -p --color always {-1}";
      };
    };
  };
}
