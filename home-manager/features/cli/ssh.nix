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
        IdentityFile ~/.ssh/rbmpc-to-gh

      Host gitlab.com
        User git
        IdentityFile ~/.ssh/rbmpc-to-gh

      Host mcgeedia
        Hostname media.mcgee.network
        IdentityFile ~/.ssh/rbmpc-to-mcgeedia

      Host nixedia
        Hostname 10.35.20.142
        IdentityFile ~/.ssh/rbmpc-to-nixedia
        ProxyJump josh@mcgeedia

      Host proxmox
        Hostname 10.35.20.11
        IdentityFile ~/.ssh/rbmpc-to-proxmox
        ProxyJump josh@mcgeedia

    '';
  };
  services.ssh-agent.enable = true;
}
