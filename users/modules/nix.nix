{ config, pkgs, lib, ... }:
let
  depends = pkgs.writeScriptBin "depends" ''
    dep=$1
    nix-store --query --requisites $(which $dep)
  '';

in { home.packages = with pkgs; [ nixfmt depends nix-prefetch-github ]; }
