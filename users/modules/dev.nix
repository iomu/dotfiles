{ config, pkgs, lib, ... }:
let
  evans = pkgs.buildGoModule rec {
    pname = "evans";
    version = "0.9.3";

    src = pkgs.fetchFromGitHub {
      owner = "ktr0731";
      repo = "evans";
      rev = "v${version}";
      sha256 = "1jy73737ah0qqy16ampx51cchrjrhkr945lpfnnshnalk86xdhdb";
    };

    vendorSha256 = "1y98alg153p2djn7zxvpyiprdzpra2nxyga8qjark38hpfnnbm4y";

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
