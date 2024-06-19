{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--glob=!.git/*"
      "--max-columns=120"
      "--max-columns-preview"
      "smart-case"
    ];
  };
}
