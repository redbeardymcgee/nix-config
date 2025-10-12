{pkgs, ...}: {
  home.package = with pkgs; [
    protonvpn-gui
    wireguard-tools
  ];
}
