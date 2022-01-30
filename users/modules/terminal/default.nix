{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    tree
    fd
    bat
    ripgrep
    tealdeer
    yq-go
    jq
    htop
    glances
  ];

  programs.fzf = { enable = true; };

  programs.starship = { enable = true; };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
