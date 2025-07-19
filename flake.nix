# Copyright (c) 2023 Alexander Nabokikh
{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      cam = {
        name = "cam";
        fullName = "Cam Schriever";
        email = "";
        avatar = ./files/avatar/icon.png; #512x512
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [./hosts/${hostname}/configuration.nix];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./home/${username}/${hostname}.nix
        ];
      };
  in {
    #System Config
    nixosConfigurations = {
      nix-xps = mkNixosConfiguration "nix-xps" "cam";
      nix-latitude = mkNixosConfiguration "nix-latitude" "cam";
      turtwig = mkNixosConfiguration "turtwig" "cam";
    };
    #Home Manager Config
    homeConfigurations = {
      "cam@nix-xps" = mkHomeConfiguration "x86_64-linux" "cam" "nix-xps";
      "cam@nix-latitude" = mkHomeConfiguration "x86_64-linux" "cam" "nix-latitude";
      "cam@turtwig" = mkHomeConfiguration "x86_64-linux" "cam" "turtwig";
    };
  };
}
