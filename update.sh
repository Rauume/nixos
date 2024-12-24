#! /bin/bash

echo "Updating NixOS"

nix flake update;
sudo nixos-rebuild switch --upgrade --flake .#nix-xps;
home-manager switch --flake .#cam@nix-xps;