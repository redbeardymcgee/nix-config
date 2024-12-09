{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    compression = true;
    # controlMaster = "yes";
    controlPersist = "yes";
    controlPath = "\${XDG_RUNTIME_DIR}/%u@%L-to-%r@%h";

    extraConfig = ''
      Host github.com
        User git
        IdentityFile ~/.ssh/arcturus-to-github

      Host gitlab.com
        User git
        IdentityFile ~/.ssh/arcturus-to-gitlab

      Host mcgeedia
        Hostname media.mcgee.network
        IdentityFile ~/.ssh/arcturus-to-mcgeedia

      Host perseus
        Hostname 192.168.1.150
        IdentityFile ~/.ssh/arcturus-to-perseus

      Host mythicdnor
        Hostname mythicdnor.ddns.net
        Port 61222
        User foundry
        IdentityFile ~/.ssh/arcturus-to-mythicdnor
    '';
  };
}
