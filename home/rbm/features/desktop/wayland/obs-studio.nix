{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;

    # enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-advanced-masks
      obs-aitum-multistream
      obs-pipewire-audio-capture
      obs-source-record
      obs-vkcapture
      obs-websocket
      wlrobs
    ];
  };
}
