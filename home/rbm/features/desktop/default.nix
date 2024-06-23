{ pkgs, ... }: {
  environment = {
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
    systemPackages = with pkgs; [
      libnotify
    ];
  };

  home.packages = with pkgs; [
    nyxt
    pamixer
    qpwgraph
    element-desktop
    vesktop
  ];
  services.easyeffects.enable = true;
}
