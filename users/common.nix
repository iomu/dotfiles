{ config, pkgs, lib, ... }: {
  imports = [
    ./modules/audio.nix
    ./modules/dev.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/nix.nix
    ./modules/system-management/index.nix
    ./modules/desktop/default.nix
    ./modules/desktop/wm/awesome.nix
    ./modules/terminal/default.nix
    ./modules/terminal/alacritty.nix
    ./modules/terminal/tmux.nix
    ./modules/terminal/vim.nix
    ./modules/terminal/zsh.nix
  ];
}
