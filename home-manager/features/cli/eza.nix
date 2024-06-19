{
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    extraOptions = [
      "--all"
      "--extended"
      "--group-directories-first"
      "--header"
      "--links"
      "--inode"
      "--modified"
      "--mounts"
      "--smart-group"
      "--total-size"
    ];
  };
}
