{ pkgs, ...}: {
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code-nerdfont;
      }
    ];
    hwRender = true;
  };
}
