{pkgs, ...}: {
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];
  hardware.graphics.extraPackages = with pkgs; [
    vpl-gpu-rt
  ];
  # services.xserver.videoDrivers = ["modesetting"];
}
