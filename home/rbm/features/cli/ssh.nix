{config, ...}: {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        forwardAgent = true;
        addKeysToAgent = "yes";
        compression = true;
        controlPersist = "yes";
        # controlPath = "$${XDG_RUNTIME_DIR}/%u@%L-to-%r@%h";
        controlPath = "${config.xdg.stateHome}/%u@%L-to-%r@%h";
      };
      "github.com" = {
        host = "github.com";
        user = "git";
        identityFile = "~/.ssh/toliman-to-github";
      };
      "gitlab.com" = {
        host = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/toliman-to-gitlab";
      };
      "mcgeedia" = {
        hostname = "mcgee.network";
        identityFile = "~/.ssh/toliman-to-mcgeedia";
      };
      "perseus" = {
        hostname = "203.0.113.250";
        port = 2222;
        identityFile = "~/.ssh/toliman-to-perseus";
      };
      "forgejo" = {
        hostname = "git.mcgee.red ";
        user = "git";
        identityFile = "~/.ssh/toliman-to-forgejo";
      };
      "git.mcgee.red" = {
        user = "git";
        identityFile = "~/.ssh/toliman-to-forgejo";
      };
    };
  };
}
