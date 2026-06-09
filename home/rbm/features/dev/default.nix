{pkgs, ...}: {
  imports = [
    ./git.nix
    ./gitui.nix
    ./go.nix
    ./lazygit.nix
    ./nvim.nix
    ./opencode.nix
    ./posting.nix
    ./tokei.nix
  ];
}
