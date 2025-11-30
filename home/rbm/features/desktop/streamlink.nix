{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    chatterino7
    chromium # NOTE: GUI depends on this
    streamlink-twitch-gui-bin
  ];
  programs.streamlink = {
    enable = true;

    # settings = {
    ## WARN: GUI wants to control the full config
    #   player = "mpv";
    #   player-args = "--cache 2048";
    #   player-no-close = true;
    # };

    # plugins = {
    #   twitch.settings = {
    ## TODO: Supported in 8.0.0
    #     twitch-supported-codecs = "h264,h265,av1";
    #   };
    # };
  };
}
