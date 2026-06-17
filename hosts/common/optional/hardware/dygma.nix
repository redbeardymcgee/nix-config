{pkgs, ...}: {
  services.udev.packages = [pkgs.bazecor];
  environment.systemPackages = with pkgs; [
    bazecor
    # terminal-typeracer
  ];
}
