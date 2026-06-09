{
  programs.chawan = {
    enable = true;

    settings = {
      buffer = {
        images = true;
      };
      external = {
        download-dir = "~/Downloads/";
        copy-cmd = "wl-copy";
        paste-cmd = "wl-paste";
      };
    };
  };
}
