{pkgs, ...}: {
  home.packages = [ pkgs.tokei ];

  xdg.configFile."tokei/tokei.toml" = {
    enable = true;
    source = (pkgs.formats.toml {}).generate "tokei.toml" {
      treat_doc_strings_as_comments = true;
    };
  };
}
