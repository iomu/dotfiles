{ config, pkgs, lib, ... }: {
  programs.atuin.enableFishIntegration = true;
  programs.skim.enableFishIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.kitty.shellIntegration.enableFishIntegration = true;
  programs.zoxide.enableFishIntegration = true;

  programs.fish = {
    enable = true;

    # TODO hermit

    shellAliases = {
      scrcpy = "ADB=$HOME/Android/Sdk/platform-tools/adb scrcpy";
      gs = "git status";
    };
  };

  home.packages = [pkgs.babelfish];
}
