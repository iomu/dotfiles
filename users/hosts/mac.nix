{ config, pkgs, lib, inputs, ... }: {

  custom = {
    system = "mac";
    user = "johannes.mueller";
    git.userEmail = "johannes.mueller@freiheit.com";
    ghostty = pkgs.ghostty-bin;
  };

  home.packages = [ pkgs.graphviz ];
}
