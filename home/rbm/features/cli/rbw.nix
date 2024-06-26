{ pkgs, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "redbeardymcgee@gmail.com";
      lock_timeout = 86400;
      pinentry = pkgs.rofi-pinentry;
    };
  };
}
