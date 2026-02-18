{ config, pkgs, lib, ... }: {
  programs.ghostty = {
    enable = true;
    package = config.custom.ghostty;

    settings = {
      font-family = "JetBrainsMonoNL Nerd Font Mono";
      font-size = 16;
      font-thicken = true;
      theme = "catppuccin-mocha";
      window-padding-x = 16;
      window-padding-y = 16;
      keybind = [ "global:alt+grave_accent=toggle_quick_terminal" ];
      command =
        "${pkgs.zsh}/bin/zsh -i -l -c ${lib.getExe config.custom.shell}";
    };
  };
}
