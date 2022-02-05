#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.arch.activationPackage" && ./result/activate
popd
