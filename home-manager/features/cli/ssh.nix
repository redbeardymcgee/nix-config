{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    compression = true;
    extraConfig = ''
      Host *
        User josh

      Host mcgeedia
        Hostname media.mcgee.network
        IdentityFile ~/.ssh/rbmpc-to-mcgeedia

      Host proxmox
        Hostname 10.35.20.11
        IdentityFile ~/.ssh/rbmpc-to-proxmox
        ProxyJump josh@mcgeedia

      Host nixedia
        Hostname 10.35.20.142
        IdentityFile ~/.ssh/rbmpc-to-nixedia
        ProxyJump josh@mcgeedia
    '';
  };
}
