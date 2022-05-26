#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.mac.activationPackage" --extra-experimental-features nix-command --extra-experimental-features flakes && ./result/activate
popd