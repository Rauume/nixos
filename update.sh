#!/bin/bash
# Check if an argument was passed
if [ -z "$1" ]; then
  echo "Usage: $0 \"your string here\""
  exit 1
fi

# Output the provided string
echo "Updating NixOS: $1"

nix flake update;
sudo nixos-rebuild switch --upgrade --flake .#$1;
home-manager switch --flake .#cam@$1;
