{ config, pkgs, lib, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-desktop.sh}";
in {
  programs.git.userEmail = "muellerjohannes23@gmail.com";
  home.packages = [ apply-user ];
}
