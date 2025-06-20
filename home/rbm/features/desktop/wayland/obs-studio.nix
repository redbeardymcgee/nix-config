{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;

    # enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-websocket
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
}
