{ ... }: {
  programs.tofi = {
    enable = true;
    settings = {
      ascii-input = true;
      auto-accept-single = false;
      fuzzy-match = true;
      hide-cursor = true;
      hint-font = false;

      font = "FiraCode Nerd Font";
      font-size = 16;
      outline-width = 0;
      border-width = 0;
      padding-left = "4%";
      padding-top = "2%";
      padding-right = 0;
      padding-bottom = 0;

      width = "45%";
      height = "40%";
    };
  };
}
