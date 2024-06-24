{ ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=10";
        fields = "categories,comment,exec,filename,generic,keywords,name";
        terminal = "footclient";
      };
    };
  };
}
