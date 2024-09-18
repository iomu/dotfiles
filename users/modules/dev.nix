{ config, pkgs, lib, inputs, ... }:
let
  evans = pkgs.buildGoModule rec {
    pname = "evans";
    version = "0.10.9";

    src = inputs.evans.outPath;

    vendorHash =
      "sha256-HcD7MnUBPevGDckiWitIcp0z97FJmW3D0f9SySdouq8="; # lib.fakeSha256

    subPackages = [ "." ];
  };
in {
  home.packages = with pkgs;
    [
      # docker
      docker-compose

      # proto + grpc
      evans
      protobuf

      bruno 
      
      gnumake42

      # kubernetes
      kubectl
      kustomize
      k9s
      skaffold
      istioctl

      # infra
      terraform
      tflint
      terrascan
      terraform-docs

      sops

      # go
      go

      lcov
      gettext
      # java
      jdk
      maven

      kotlin
      ktlint

      nodejs

      postgresql

      yarn

      vegeta

      rustup
    ] ++ lib.optionals pkgs.stdenv.isLinux [ jetbrains-toolbox libtree ];
}
