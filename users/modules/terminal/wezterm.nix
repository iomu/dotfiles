{ config, pkgs, pkgs-stable, lib, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        color_scheme = "Catppuccin Mocha",
        font = wezterm.font('JetBrainsMonoNL Nerd Font Mono', { weight = 'Bold'}),
        font_size = ${if pkgs.stdenv.isDarwin then "16" else "12"},
        hide_tab_bar_if_only_one_tab = true,
        default_prog = { "${pkgs.zsh}/bin/zsh", "-i", "-l", "-c", "${pkgs.nushell}/bin/nu" },
      }
    '';
  };
}
