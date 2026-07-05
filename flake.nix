{
  description = "Multi-system Nix configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        sulla = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nixos-hardware; };
          modules = [ ./hosts/sulla/sulla.nix ];
        };
        nomi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nixos-hardware; };
          modules = [ ./hosts/nomi/nomi.nix ];
        };
      };
    };
}
