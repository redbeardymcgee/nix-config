{
  config,
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
  [
    inputs.catppuccin.homeManagerModules.catppuccin

    ../features/cli
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

   catppuccin = {
     enable = true;
     flavor = "mocha";
   };

  news.display = "silent";

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    packages = with pkgs; [
      gcc
      unzip
    ];
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      NODE_PATH = "$HOME/local/lib/node_modules";
      VISUAL = "nvim";
    };
    username = lib.mkDefault "${config.home.username}";
  };

   services = {
     playerctld.enable = true;
     remmina.enable = true;
     ssh-agent.enable = true;
   };
}
