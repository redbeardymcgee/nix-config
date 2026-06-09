{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    settings = {
      user = {
        name = "redbeardymcgee";
        email = "redbeardymcgee@proton.me";
      };
      alias = {
        co = "checkout";
        dlog = "log -p --ext-diff";
      };
      branch.sort = "committerdate";
      column.ui = "auto";
      commit.verbose = true;
      diff.algorithm = "histogram";
      init = {
        defaultBranch = "main";
      };
      log.date = "iso";
      pull = {
        ff = "only";
      };
      color = {
        ui = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      pager = {
        colorMoved = "default";
      };
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
    ignores = [
      "*~"
      "*.swp"
      "*.bak"
    ];
  };
}
