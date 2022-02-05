{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  systemd.user.sessionVariables = { EDITOR = "vim"; };
  home.sessionVariables = { EDITOR = "vim"; };
}
