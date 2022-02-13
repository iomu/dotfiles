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
    du-dust
    bandwhich
    # count code
    tokei
    # like sed
    sd
    # colors
    pastel
    # http requests
    xh
    # ps
    procs
    # kubernetes
    click
    # json
    fx
    # hex viewer
    hexyl
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = { enable = true; };

  programs.starship = { enable = true; };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  # z
  programs.zoxide = { enable = true; };

  # like htop
  programs.bottom = { enable = true; };

  # directory navigation: br
  programs.broot = { enable = true; };


  programs.navi = { enable = true; };
}
