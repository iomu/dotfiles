#!/bin/sh
pushd $HOME/dotfiles
nix build "$HOME/dotfiles#homeConfigurations.work.activationPackage" && ./result/activate
popd