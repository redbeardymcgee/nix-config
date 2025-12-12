{pkgs, ...}: {
  services.kmscon = {
    enable = true;
    autologinUser = "rbm";
    hwRender = true;
    useXkbConfig = true;
    fonts = [
      {
        name = "FiraCode Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
      }
    ];
  };
}
