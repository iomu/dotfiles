#!/bin/sh
# impure due to nvidia version detection for nixGL
home-manager switch --flake "$HOME/dotfiles#arch" --impure
