let
  asus = "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817";
  samsung = "Samsung Electric Company SE790C Unknown";
in [
  {
    ## NOTE: I think this should not be set for these to be global
    # matches = [{app-id = ".*";}];
    ## NOTE: DMS seems to set this globally, but it again sets the same value for others
    # geometry-corner-radius = 12;

    clip-to-geometry = true;
    tiled-state = true;
    draw-border-with-background = false;
  }
  {
    matches = [{is-active = false;}];
    opacity = 0.9;
  }
  {
    matches = [
      {app-id = "org.quickshell$";}
      {app-id = "com.danklinux.dms$";}
      {app-id = "^xdg-desktop-portal$";}
      {
        app-id = "firefox$";
        title = "^Picture-in-Picture$";
      }
      {title = "^Picture in picture$";}
      {app-id = "zoom";}
    ];
    open-floating = true;
  }
  {
    matches = [
      {
        app-id = "^steam$";
        title = "^notifications_\d+_desktop$";
      }
    ];
    default-floating-position = {
      x = 10;
      y = 10;
      relative-to = "bottom-right";
    };
    open-focused = false;
  }
  {
    ## NOTE: Work around WezTerm's inital configure bug
    matches = [
      {
        app-id = "^org\.wezfurlong\.wezterm$";
      }
    ];
    default-column-width = {};
  }
  {
    matches = [{app-id = "^thunderbird$";}];
    open-on-output = samsung;
    open-on-workspace = "5";
  }
  {
    matches = [{app-id = ''^"Nextcloud Talk"$'';}];
    open-on-output = samsung;
    open-on-workspace = "5";
  }
  {
    matches = [{app-id = "^ghostty\.monitor$";}];
    open-on-output = samsung;
    open-on-workspace = "1";
  }
  {
    matches = [{app-id = "^com\.moonlight_stream\.Moonlight$";}];
    open-on-output = asus;
    open-on-workspace = "8";
  }
  {
    matches = [{app-id = "^org\.qbittorrent\.qBittorrent$";}];
    open-on-output = samsung;
    open-on-workspace = "9";
  }
  {
    matches = [{app-id = "^ghostty\.localhost$";}];
    open-on-output = asus;
    open-on-workspace = "1";
  }
  {
    matches = [{app-id = "^Bitwarden$";}];
    block-out-from = "screen-capture";
  }
]
