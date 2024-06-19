{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        ".ignore:Git Ignore"
      ];
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };
}
