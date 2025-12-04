{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.opencl
      rocmPackages.clr.icd
    ];
  };
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
