{
  programs.direnv = {
    enable = true;
    # enableFishIntegration = true; # set by upstream somehow?
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = true;
        strict_env = true;
      };
    };
  };
}
