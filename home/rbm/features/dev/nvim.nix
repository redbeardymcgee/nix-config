{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.redvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANROFFOPT = "-c";
  };
}
