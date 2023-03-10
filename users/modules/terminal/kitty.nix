{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      # name = "Fira Code Semibold Nerd Font Complete";
      name = "JetBrains Mono Bold Nerd Font Complete";
      size = 12;
    };
    theme = "Catppuccin-Mocha";
    keybindings = {
      "ctrl+f" =
        "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i --tac";
    };
    settings = { scrollback_lines = 10000; };
  };
}
