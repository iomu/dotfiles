{ config, pkgs, lib, ... }:
let
  apply-system = pkgs.writeScriptBin "apply-system" ''
    ${builtins.readFile ./apply-system.sh}
  '';
  update-system = pkgs.writeScriptBin "update-system" ''
    ${builtins.readFile ./update-system.sh}
  '';
  update-user = pkgs.writeScriptBin "update-user" ''
    ${builtins.readFile ./update-user.sh}
  '';
in { home.packages = [ apply-system update-system update-user ]; }
