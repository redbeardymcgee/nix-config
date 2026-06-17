{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [inputs.oxicord.packages.${pkgs.stdenv.hostPlatform.system}.default];
}
