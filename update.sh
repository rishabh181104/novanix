#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

echo "Updating Flake"
sudo nix flake update

echo "Updating System"
sudo nixos-rebuild switch --flake .#novanix

echo "Updating Home-manager"
home-manager --switch --flake .nova
