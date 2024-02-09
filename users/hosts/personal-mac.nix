{ config, pkgs, lib, inputs, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user" "${builtins.readFile
    ../modules/system-management/apply-user-personal-mac.sh}";
  terminal = "${pkgs.kitty}/bin/kitty";
in {
  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = "jo";
  };

  programs.git.userEmail = "muellerjohannes23@gmail.com";
  home.packages = [ apply-user ];

  home.sessionVariables = { TERMINAL = terminal; };

  #  home.sessionPath = [ "$HOME/.rd/bin" ];
}
