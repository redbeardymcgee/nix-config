{pkgs, ...}: {
  programs.rbw = {
    enable = false;
    settings = {
      email = "redbeardymcgee@gmail.com";
      lock_timeout = 86400;
      pinentry = pkgs.pinentry-curses;
    };
  };
}
