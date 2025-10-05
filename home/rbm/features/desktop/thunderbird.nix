{pkgs, ...}: {
  # home.packages = [pkgs.protonmail-bridge-gui];
  programs.thunderbird = {
    enable = true;

    profiles = {
      main = {
        isDefault = true;

        # settings = {};
      };
    };
  };

  # accounts.email.accounts.rbm = {
  #   thunderbird = {
  #     enable = true;
  #     profiles = ["main"];
  #   };
  # };
}
