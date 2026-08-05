{ config, pkgs, lib, inputs, ... }: {

  custom = {
    system = "mac";
    user = "johannes.mueller";
    git.userEmail = "johannes.mueller@freiheit.com";
    ghostty = pkgs.ghostty-bin;
  };

  home.packages = [ pkgs.graphviz pkgs.github-copilot-cli pkgs.azure-cli ];
}
