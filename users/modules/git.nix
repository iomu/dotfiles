{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ git-crypt gh ];

  programs.git = {
    enable = true;
    userName = "Johannes Müller";
    aliases = {
      co = "checkout";
      ri = "rebase --interactive";
      st = "status";
      publish =
        "!sh -c 'git push origin HEAD:$(git rev-parse --abbrev-ref HEAD)' -";
      feature = "!sh -c 'git checkout -b jomü/$1 origin/master' -";
    };
    delta.enable = true;

    extraConfig = { core = { editor = "vim"; }; };
  };
}
