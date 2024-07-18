{pkgs, ...}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "redbeardymcgee@gmail.com";
      lock_timeout = 86400;
      pinentry = pkgs.pinentry-gnome3;
    };
  };

  home.packages = with pkgs; [
    rofi-rbw
    wtype
  ];

  wayland.windowManager.river.settings.map.normal = {
    "Super P" = "spawn rofi-rbw";
  };
}
