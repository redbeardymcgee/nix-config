{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      cycle = true;
      font = "FiraCode Nerd Font 14";
      modes = "combi,drun,window";
      terminal = "${pkgs.foot}/bin/foot";
      kb-primary-paste = "Control+v,Shift+Insert";
      kb-secondary-paste = "Control+Shift+v,Control+Insert";
      matching = "fuzzy";
      sorting-method = "fzf";
    };
  };

  home = {
    packages = with pkgs; [
      pinentry-rofi
      rofimoji
      rofi-bluetooth
      rofi-power-menu
      rofi-pulse-select
      rofi-rbw
      # rofi-screenshot
    ];
    sessionVariables = {
      ROFI_SYSTEMD_TERM = "${pkgs.foot}/bin/foot";
    };
  };
}
