{ config, pkgs, lib, ... }:
let
  colima-docker = pkgs.writeScriptBin "cdocker" ''
    ${pkgs.colima}/bin/colima nerdctl -- $@
  '';
in {

  home.packages = [
    pkgs.colima
    pkgs.cocoapods
    pkgs.rubyPackages.xcodeproj
    colima-docker
    pkgs.docker-client
    pkgs.docker-credential-helpers
    pkgs.docker-credential-gcr
  ];

  home.sessionVariables = {
    DOCKER_HOST =
      "unix://${config.home.homeDirectory}/.colima/default/docker.sock";
  };
}
