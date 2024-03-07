{ config, pkgs, lib, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        color_scheme = "Catppuccin Mocha",
        font = wezterm.font('JetBrainsMonoNL Nerd Font Mono', { weight = 'Bold'}),
        font_size = ${if pkgs.stdenv.isDarwin then "16" else "12"},
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = true,
        enable_scroll_bar = true,
        max_fps = 120,
        window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
        default_prog = { "${pkgs.zsh}/bin/zsh", "-i", "-l", "-c", "${
          lib.getExe config.custom.shell
        }" },
      }
    '';
  };
}
