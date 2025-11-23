{pkgs, ...}: {
  hardware.openrazer = {
    enable = true;
    users = ["rbm"];
  };

  environment.systemPackages = with pkgs; [
    polychromatic
    razer-cli
  ];
}
