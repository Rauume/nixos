#!/bin/bash
# Check if an argument was passed
if [ -z "$1" ]; then
  echo "Usage: $0 \"machine-name\""
  exit 1
fi

echo "Updating NixOS: $1"

# Update package references/nix flake inputs
nix flake update;

# Build and switch to the new instance
sudo nixos-rebuild switch --flake .#$1;

# Update home-manager packages, from the flake
home-manager switch --flake .#cam@$1;
