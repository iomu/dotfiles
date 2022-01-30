{ config, pkgs, lib, ... }: {
  programs.fzf.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

    prezto = {
      enable = true;
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "git"
        "docker"
      ];
    };

    initExtra = let
      gfuzzy = pkgs.fetchFromGitHub {
        owner = "bigH";
        repo = "git-fuzzy";
        rev = "6f1354411ddfa27c1162ebed73ee61dfbd71eb1a";
        sha256 = "094p605db42s9xjzbs8akc0yfhwf9l6alzsfimwmil99i8a52sr3";
      };
    in ''
      export PATH=$PATH:/home/jo/Downloads/flutter/bin:$HOME/bin:$HOME/Downloads/flutter/bin/cache/dart-sdk/bin:$HOME/.pub-cache/bin:$HOME/go/bin:$HOME/Android/Sdk/platform-tools:$HOME/.cargo/bin
      export PATH=$PATH:${gfuzzy}/bin
    '';

    shellAliases = {
      scrcpy = "ADB=$HOME/Android/Sdk/platform-tools/adb scrcpy";
      gs = "git status";
    };

    sessionVariables = { EDITOR = "vim"; };
  };
}
