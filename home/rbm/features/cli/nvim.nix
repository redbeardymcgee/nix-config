{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nixcats.packages.${pkgs.stdenv.hostPlatform.system}.redvim
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANROFFOPT = "-c";
  };
}
