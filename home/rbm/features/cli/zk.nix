{config, ...}: {
  home.sessionVariables = {
    ZK_NOTEBOOK_DIR = "$XDG_DOCUMENTS_DIR/Notebook";
  };

  programs.zk = {
    enable = true;

    settings = {
      alias = {
        bl = ''zk list --link-to "$@"'';
        ls = ''zk list "$@"'';
        ed = ''zk edit "$@"'';
        n = ''zk new --title "$*"'';
        wc = ''zk list --format "{{word-count}}\t{{title}}" --sort word-count "$@"'';
        conf = ''$EDITOR "$ZK_NOTEBOOK_DIR/.zk/config.toml"'';
        log = ''zk list --quiet --format path --delimiter0 "$@" | xargs -0 git log --patch --'';
        last = ''zk edit --limit 1 --sort modified- "$@"'';
        lucky = "zk list lucky";
        recent = "zk edit recents --interactive";
        unlinked-mentions = ''zk list --mentioned-by "$1" --no-linked-by "$1"'';
      };

      extra.author = "rbm";

      filter = {
        lucky = "--quiet --format full --sort random --limit 1";
        recents = "--sort created- --created-after 'last two weeks'";
      };

      format = {
        markdown = {
          link-format = "[[{{metadata.id}}|{{title}}]]";
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

      notebook.dir = "${config.home.homeDirectory}/Documents/Notebook";

      tool = {
        fzf-preview = "bat -p --color always {-1}";
      };
    };
  };
}
