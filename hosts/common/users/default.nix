{
  inputs,
  outputs,
  ...
}: {
  imports = [
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
