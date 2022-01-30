{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -g mouse on
      bind | split-window -h
      bind - split-window -v
      bind r source-file ~/.tmux.conf
      set-option -g allow-rename off
    '';
  };
}
