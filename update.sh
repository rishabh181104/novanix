#!/usr/bin/env bash

echo "Updating Flake"
sudo nix flake update

echo "Updating System"
sudo nixos-rebuild switch --flake .#novanix

echo "Updating Home-manager"
home-manager --switch --flake .nova
