{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./go.nix
    ./htop.nix
    ./jq.nix
    ./lazygit.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./nix.nix
    ./nvim.nix
    ./rbw.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux
    ./tokei.nix
    ./yazi
    ./zk.nix
    ./zoxide.nix
  ];

  # TODO: Review after kixvim is running
  home.packages = with pkgs; [
    # kixvim

    # nix tools
    alejandra
    comma
    manix

    # Generally useful
    difftastic
    entr
    gtrash
    procs
    typos
    yq
    transmission_4

    # Editor support
    cargo
    nodejs
    python3
    tree-sitter

    # Yazi deps but generally useful
    exiftool
    glow
    hexyl
    miller
    ouch
    poppler
    ripdrag
  ];
}
