{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    OVMF
    qemu_kvm
    qemu-utils
    quickemu
    quickgui
  ];

  programs = {
    virt-manager.enable = true;
  };

  virtualisation = {
    kvmgt = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
}
