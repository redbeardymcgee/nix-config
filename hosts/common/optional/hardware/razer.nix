{
  pkgs,
  pkgs-unstable,
  ...
}: {
  hardware.openrazer = {
    enable = true;
    users = ["rbm"];
  };

  environment.systemPackages = with pkgs;
    [
      # polychromatic
      # razer-cli
    ]
    ++ (with pkgs-unstable; [
      polychromatic
      razer-cli
    ]);
}
