{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    compression = true;
    controlPersist = "10m";

    extraConfig = ''
      Host *
        User josh

      Host github.com
        User git
        IdentityFile ~/.ssh/arcturus-to-gh

      Host gitlab.com
        User git
        IdentityFile ~/.ssh/arcturus-to-gh

      Host mcgeedia
        Hostname media.mcgee.network
        IdentityFile ~/.ssh/arcturus-to-mcgeedia

      Host nixedia
        Hostname 10.35.20.142
        IdentityFile ~/.ssh/arcturus-to-nixedia
        ProxyJump josh@mcgeedia

      Host proxmox
        Hostname 10.35.20.11
        IdentityFile ~/.ssh/arcturus-to-proxmox
        ProxyJump josh@mcgeedia
    '';
  };

  services.ssh-agent.enable = true;
}
