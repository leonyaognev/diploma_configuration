{ inputs, ... }: {
  flake.nixosModules.homeManager = { config, pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.ognev = import ../../home/home.nix;
  };
}