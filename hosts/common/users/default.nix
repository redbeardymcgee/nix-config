{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./rbm
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  users.mutableUsers = false;
}
