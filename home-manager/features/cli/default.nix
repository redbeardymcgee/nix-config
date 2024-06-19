{ pkgs, ... }: {
  imports = [
    ./atuin.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    curlie
    difftastic
    dogdns
    entr
    gping
    grex
    gtrash
    hexyl
    lazydocker
    miller
    neovim
    nerdfonts
    nmap
    nodejs
    ouch
    procs
    python3
    python311Packages.libtmux
    ripdrag
    rustup
    yq
  ];
}

