{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    lfs.enable = true;
    userName = "redbeardymcgee";
    userEmail = "redbeardymcgee@proton.me";
    aliases = {
      co = "checkout";
      dlog = "log -p --ext-diff";
    };
    difftastic.enable = true;
    extraConfig = {
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
