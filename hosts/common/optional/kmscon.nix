{ pkgs, ...}: {
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "FiraCode Nerd Font:size=10";
        package = pkgs.fira-code-nerdfont;
      }
    ];
    hwRender = true;
  };
}
