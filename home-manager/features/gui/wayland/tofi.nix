{ ... }: {
  programs.tofi = {
    enable = true;
    settings = {
      ascii-input = true;
      auto-accept-single = true;
      fuzzy-match = true;
      hide-cursor = true;
      hint-font = false;
      # matching-algorithm = "fuzzy";

      # Theme options
      font = "FiraCode";
      font-size = 20;

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
