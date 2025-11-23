{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
  ];
  home.sessionVariables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
