{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./aerc.nix
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./browsh.nix
    ./comma.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch
    ./fd.nix
    ./fish.nix
    ./fsel.nix
    ./fzf.nix
    ./git.nix
    ./go.nix
    ./gurk.nix
    ./htop.nix
    ./iamb.nix
    ./jq.nix
    ./lazygit.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./otter-launcher.nix
    ./posting.nix
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

  home.packages = with pkgs; [
    inputs.nixcats.packages.${system}.redvim
    inputs.posting.packages.${system}.default

    # nix tools
    alejandra
    # comma
    manix

    # Generally useful
    bun
    clipboard-jh
    csview
    csvlens
    difftastic
    discordo
    distrobox
    entr
    gtrash
    magic-wormhole
    procs
    protonvpn-cli
    sass
    typos
    xan
    yq

    # Editor support
    # cargo
    # nodejs
    # python3
    # tree-sitter

    # Yazi deps but generally useful
    exiftool
    file
    glow
    hexyl
    miller
    ouch
    p7zip
    poppler
    ripdrag
  ];
}
