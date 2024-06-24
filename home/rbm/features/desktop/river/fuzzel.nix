{ ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=10";
        fields = "categories,comment,exec,filename,generic,keywords,name";
        terminal = "footclient";
      };
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-match = "f38ba8ff";
        selection-text = "cdd6f4ff";
        border = "b4befeff";
      };
    };
  };
}
