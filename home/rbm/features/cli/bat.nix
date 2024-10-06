{pkgs, ...}: {
  home.sessionVariables = {
    BATPAGER = "less -FiRX";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  programs = {
    bat = {
      enable = true;
      config = {
        map-syntax = [
          ".ignore:Git Ignore"
        ];
      };
      extraPackages = with pkgs.bat-extras; [
        # batdiff
        batgrep
        batman
        batpipe
        batwatch
        prettybat
      ];
    };

    fish.shellAliases = {
      bathelp = "bat --plain --language=help";
    };
  };
}
