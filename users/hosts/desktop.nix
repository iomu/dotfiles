{ config, pkgs, lib, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-desktop.sh}";
in {
  custom = { system = "desktop"; };

  imports = [ ../modules/desktop/wm/awesome.nix ];
  programs.git.userEmail = "muellerjohannes23@gmail.com";

  xsession.windowManager.i3.config.terminal = "alacritty";

  home.packages = with pkgs; [
    apply-user
    google-chrome
    spotify
    jetbrains.idea-ultimate
    androidStudioPackages.canary
  ];
}
