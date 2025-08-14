{pkgs, ...}: {
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  # services.xserver.videoDrivers = ["modesetting"];
}
