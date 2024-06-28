{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    OVMF
    qemu_kvm
    qemu-utils
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
  };
}
