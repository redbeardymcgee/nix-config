{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [pkgs.posting];
  # programs.posting = {
  #   enable = true;
  #   settings = {
  #     animation = "full";
  #   };
  # };
}
