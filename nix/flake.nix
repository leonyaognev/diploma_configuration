{
  description = "diploma nixos configuration. server with ci/cd";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:leonyaognev/nixvim-config";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs: {
    nixosConfigurations.diploma = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; sopsFile = ./secrets.enc.yaml; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
      ];
    };
  };

}

