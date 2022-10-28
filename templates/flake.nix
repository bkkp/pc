{
  nixConfig.flake-registry = "https://raw.githubusercontent.com/bkkp/flake-registry/nixos-22.05/flake-registry.json";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, pc, nix, sops-nix, home-manager }@inputs:
  {
    nixosConfigurations.gauss = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        pc.nixosModules.hdw-hp-elitebook-830-g5
        pc.nixosModules.default
        {
          midgard.pc = {
            hostName = "gauss";
            nixbuild.enable = true;
            users = {
              kristoffer = {
                fullName = "Kristoffer K. Føllesdal";
                email = "kristoffer.follesdal@eviny.no";
                git.userName = "kfollesdal";
              };
            };
          };
        }
      ];
    };
  };
}
