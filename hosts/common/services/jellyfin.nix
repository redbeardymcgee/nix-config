{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  # nixpkgs.config.packageOverrides = pkgs: {
  #   intel-vaapi-drier = pkgs.intel-vaapi-drier.override {enableHybridCodec = true;};
  # };
  hardware.graphics = {
    enable = true;
    # extraPackages = with pkgs; [
    #   intel-media-driver
    #   intel-vaapi-driver
    #   vaapiVdpau
    #   intel-compute-runtime
    #   # vpl-gpu-rt # QSV on 11th gen or newer
    #   intel-media-sdk # QSV up to 11th gen
    # ];
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
