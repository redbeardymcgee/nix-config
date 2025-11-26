{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    chatterino7
  ];
  programs.streamlink = {
    enable = true;

    settings = {
      player = "mpv";
      player-args = "--cache 2048";
      player-no-close = true;
    };

    plugins = {
      twitch.settings = {
        supported-codecs = "h264,h265,av1";
      };
    };
  };
}
