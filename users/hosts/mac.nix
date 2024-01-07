{ config, pkgs, lib, inputs, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-mac.sh}";
  pkgs = import inputs.nixpkgs {
    system = "x86_64-darwin";
    config = { allowUnfree = true; };
  };
  terminal = "${pkgs.alacritty}/bin/alacritty";
in {
  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = "johannes.mueller";
  };

  programs.git.userEmail = "johannes.mueller@freiheit.com";
  home.packages = [ apply-user pkgs.cocoapods pkgs.rubyPackages.xcodeproj ];

  home.sessionVariables = { TERMINAL = terminal; };

  home.sessionPath = [ "$HOME/.rd/bin" ];
}
