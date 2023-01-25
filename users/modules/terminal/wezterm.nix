{ config, pkgs, lib, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
    local wezterm = require 'wezterm'
    return {
      color_scheme = "Catppuccin Mocha",
      font = wezterm.font('JetBrainsMonoNL Nerd Font Mono', { weight = 'Bold'}),
      font_size = 12,
      hide_tab_bar_if_only_one_tab = true,
    }
    '';
  };
}
