#!/usr/bin/env bash

echo "Updating Flake"
sudo nix flake update

echo "Updating System"
sudo nixos-rebuild switch --flake .#novanix
