{ config, pkgs, lib, ... }:
let
  depends = pkgs.writeScriptBin "depends" ''
    dep=$1
    nix-store --query --requisites $(which $dep)
  '';

in {
  home.packages = with pkgs; [ nix nixfmt depends nix-prefetch-github ];
  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = config.custom.user;
  };
}
