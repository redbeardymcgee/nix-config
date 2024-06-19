{
  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      dlog = "log -p --ext-diff";
    };
    difftastic.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        ff = "only";
      };
      color = {
        ui = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      pager = {
        colorMoved = "default";
      };
    };
    ignores = [
      "*~"
      "*.swp"
      "*.bak"
    ];
    userName = "redbeardymcgee";
    userEmail = "redbeardymcgee@gmail.com";
  };
}
