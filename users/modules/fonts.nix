{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    dejavu_fonts
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
  ];
}
