{pkgs, ...}: {
  hardware.graphics.extraPackages = with pkgs; [
    mesa.opencl
  ];
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
