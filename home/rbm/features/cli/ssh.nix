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

      Host alta-git
        Hostname github.com
        User git
        IdentityFile ~/.ssh/arcturus-to-alta@github

      Host fedora
        Hostname 192.168.1.55
        IdentityFile ~/.ssh/arcturus-to-fedora@perseus

      Host forgejo
        Hostname git.mcgee.red
        User git
        Port 60022
        IdentityFile ~/.ssh/arcturus-to-forgejo

      Host git.mcgee.red
        User git
        Port 60022
        IdentityFile ~/.ssh/arcturus-to-forgejo

    '';
  };
}
