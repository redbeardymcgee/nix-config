{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bazecor
    terminal-typeracer
  ];

  services.udev.packages = [pkgs.bazecor];
}
