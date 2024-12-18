{ config, pkgs, lib, inputs, ... }: {

  custom = {
    system = "mac";
    user = "johannes.mueller";
    git.userEmail = "johannes.mueller@freiheit.com";
  };

  home.packages = [ pkgs.graphviz ];
}
