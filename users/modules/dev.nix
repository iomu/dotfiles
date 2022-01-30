{ config, pkgs, lib, inputs, ... }:
let
  evans = pkgs.buildGoModule rec {
    pname = "evans";
    version = "0.10.2";

    src = inputs.evans.outPath;

    vendorSha256 = "sha256-bFTmr/xQ12cboH1MGvHDUpLM0dMkxMeLgwG0VbhMEnc="; # lib.fakeSha256

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
    # Azure
    azure-cli
    azure-storage-azcopy
    # infra
    terraform_0_14
    # python
    python39
    python39Packages.pip
    # go
    go
    # rust
    rustup

    lcov
    gettext
    # java
    jdk11

    gcc

    wrangler
    google-cloud-sdk
  ];
}
