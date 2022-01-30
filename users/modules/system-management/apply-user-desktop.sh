#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.nixos.activationPackage" && ./result/activate
popd