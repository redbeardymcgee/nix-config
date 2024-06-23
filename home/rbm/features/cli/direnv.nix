{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        strict_env = true;
      };
    };
  };
}
