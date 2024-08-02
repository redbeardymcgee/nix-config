{pkgs, ...}: {
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];
}