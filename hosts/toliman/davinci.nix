{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.opencl
    ];
  };
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
