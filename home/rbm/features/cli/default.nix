{
  inputs,
  outputs,
  pkgs,
  ...
}: {
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
    ./nvim.nix
    # ./rbw.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux
    ./yazi
    ./zk.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    alejandra
    comma
    devenv
    difftastic
    entr
    exiftool
    glow
    gtrash
    hexyl
    lazydocker
    manix
    miller
    # kixvim
    nodejs
    ouch
    poppler
    procs
    python3
    ripdrag
    scc
    transmission_4
    tree-sitter
    yq
  ];
}
