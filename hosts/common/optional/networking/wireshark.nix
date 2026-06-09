{pkgs, ...}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  environment.systemPackages = [pkgs.termshark];
}
