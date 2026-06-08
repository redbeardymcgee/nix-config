{
  programs.niri.settings.spawn-at-startup = [
    {
      argv = [
        "nextcloud-talk-desktop"
      ];
    }
    {
      argv = [
        "ghostty"
        "--class=ghostty.chat"
        "-e"
        "smug"
        "start"
        "chat"
      ];
    }
    {
      argv = [
        "thunderbird"
      ];
    }
    {
      argv = [
        "qbittorrent"
      ];
    }
    {
      argv = [
        "ghostty"
        "--class=ghostty.localhost"
        "-e"
        "smug"
        "start"
        "localhost"
      ];
    }
  ];
}
