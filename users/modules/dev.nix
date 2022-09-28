{ config, pkgs, lib, inputs, ... }:
let
  evans = pkgs.buildGoModule rec {
    pname = "evans";
    version = "0.10.9";

    src = inputs.evans.outPath;

    vendorSha256 =
      "sha256-HcD7MnUBPevGDckiWitIcp0z97FJmW3D0f9SySdouq8="; # lib.fakeSha256

    subPackages = [ "." ];
  };
in {
  home.packages = with pkgs; [
    docker
    docker-compose
    # proto + grpc
    evans
    protobuf

    gnumake

    # kubernetes
    kubectl
    kustomize
    k9s
    skaffold
    istioctl

    # Azure
    azure-cli
    azure-storage-azcopy
    # infra
    terraform
    # go
    go

    lcov
    gettext
    # java
    jdk11

    wrangler

    yarn

    vegeta

    rustup
  ];
}
