{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nixcats.packages.${system}.redvim
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANROFFOPT = "-c";
  };
}
