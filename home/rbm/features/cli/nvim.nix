{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim" = {
    enable = true;
    recursive = true;
    source = ./nvim;
  };

  programs.neovim = {
    enable = false;
  };
}
