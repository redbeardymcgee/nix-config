{ pkgs, ...}: {
  services.kmscon = {
    enable = true;
    extraConfig = ''
      "font-size=10"
    '';
    fonts = [
      {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code-nerdfont;
      }
    ];
    hwRender = true;
  };
}
