{
  description = "Multi-system Nix configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    probe-rs-rules = {
      url = "github:jneem/probe-rs-rules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      rust-overlay,
      probe-rs-rules,
      llm-agents,
      ...
    }:
    let
      system = "x86_64-linux";
      specialArgs = {
        inherit
          system
          nixos-hardware
          rust-overlay
          probe-rs-rules
          llm-agents
          ;
      };
    in
    {
      nixosConfigurations = {
        sulla = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [ ./hosts/sulla/sulla.nix ];
        };
        nomi = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [ ./hosts/nomi/nomi.nix ];
        };
      };
    };
}
