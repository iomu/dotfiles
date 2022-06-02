{ config, pkgs, lib, ... }: {
  imports = [ ./modules/keyboard.nix ./modules/desktop/default.nix ];

  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;

  systemd.user.sessionVariables = { EDITOR = "vim"; };
  home.sessionVariables = { EDITOR = "vim"; };
}
