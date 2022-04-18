#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.arch.activationPackage" --extra-experimental-features nix-command --extra-experimental-features flakes --impure && ./result/activate
popd
