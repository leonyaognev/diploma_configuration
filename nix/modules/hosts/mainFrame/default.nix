{ self, inputs, ... }: {
  flake.nixosConfigurations.mainFrame = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; sopsFile = ./../../../secrets.enc.yaml; };
    modules = [
      self.nixosModules.mainFrameConfiguration
    ];
  };
}