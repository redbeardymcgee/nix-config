{ pkgs, ... }: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
    ./go.nix
    ./htop.nix
    ./jq.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    ./yazi
    ./zk.nix
    ./zoxide.nix
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
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
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

