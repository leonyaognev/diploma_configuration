{
  description = "diploma nixos configuration. server with ci/cd";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim.url = "github:burs1/nixvim-config";

    # Framework for flake structuring.
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Helper, that imports all modules recursevly.
    import-tree.url = "github:vic/import-tree";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Import modules automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}