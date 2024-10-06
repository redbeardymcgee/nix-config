{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    compression = true;
    controlPersist = "10m";

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
        Hostname 192.168.1.247
        IdentityFile ~/.ssh/arcturus-to-perseus
    '';
  };
}
