{pkgs, ...}: {
  programs.localsend = {
    enable = true;
    package = pkgs.jocalsend;
    openFirewall = true;
  };
}
