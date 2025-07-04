#!/usr/bin/env bash

echo "Updating System"
sudo nixos-rebuild switch --flake .#novanix

echo "Installing Home-manager"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo "Updating Home-manager"
home-manager switch --flake .#nova
