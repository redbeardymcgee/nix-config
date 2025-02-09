{pkgs, ...}: {
  home.packages = [pkgs.browsh];

  xdg.configFile."browsh/config.toml" = {
    enable = true;
    source = (pkgs.formats.toml {}).generate "browsh.toml" {
      browsh_supporter = "I have shown my support for Browsh";
    };
  };
}
