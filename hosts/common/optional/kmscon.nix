{pkgs, ...}: {
  services.kmscon = {

    enable = true;
    hwRender = true;
    useXkbConfig = true;

    extraConfig = ''
      "font-size=10"
    '';

    fonts = [
      {
        name = "FiraCode Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      }
    ];
  };
}
