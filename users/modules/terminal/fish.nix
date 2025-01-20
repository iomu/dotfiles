{ config, pkgs, lib, ... }: {
  programs.atuin.enableFishIntegration = true;
  programs.skim.enableFishIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.ghostty.enableFishIntegration = true;
  programs.kitty.shellIntegration.enableFishIntegration = true;
  programs.zoxide.enableFishIntegration = true;

  programs.fish = {
    enable = true;

    # TODO hermit

    shellAliases = config.custom.shellAliases;
  };

  home.packages = [ pkgs.babelfish ];
}
