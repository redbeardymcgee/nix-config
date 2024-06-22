{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    OVMF
    qemu_kvm
    qemu-utils
  ];
  virtualisation = {
    kvmgt = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };
}
