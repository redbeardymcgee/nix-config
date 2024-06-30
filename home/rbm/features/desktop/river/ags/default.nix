{inputs, pkgs, ...}: {
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./cfg;
    extraPackages = with pkgs; [];
  };
}
