#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.work.activationPackage" --extra-experimental-features nix-command --extra-experimental-features flakes && ./result/activate
popd