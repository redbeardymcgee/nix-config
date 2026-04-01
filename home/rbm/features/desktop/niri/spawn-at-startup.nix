[
  {
    argv = [
      "nextcloud-talk-desktop"
    ];
  }
  # {
  #   argv = [
  #     "smug"
  #     "start"
  #     "chat"
  #   ];
  # }
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
  {
    argv = [
      "ghostty"
      "--class=ghostty.monitor"
      "-e"
      "btm"
    ];
  }
]
