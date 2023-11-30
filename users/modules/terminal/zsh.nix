{ config, pkgs, lib, ... }: {
  programs.atuin.enableZshIntegration = true;
  programs.skim.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;

    initExtra = ''
      HERMIT_ROOT_BIN="''${HERMIT_ROOT_BIN:-"$HOME/bin/hermit"}"
      eval "$(test -x $HERMIT_ROOT_BIN && $HERMIT_ROOT_BIN shell-hooks --print --zsh)"
    '';

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

    shellAliases = {
      scrcpy = "ADB=$HOME/Android/Sdk/platform-tools/adb scrcpy";
      gs = "git status";
      cd = "z";
    };

    plugins = [{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }];
  };
}
