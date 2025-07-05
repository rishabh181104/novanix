#!/usr/bin/env bash

echo "Updating System"
sudo nixos-rebuild switch --flake .#novanix
