#!/bin/sh
home-manager switch --flake "$HOME/dotfiles#$1" --impure
