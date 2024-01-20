{
  description = "A flake for auxilliary packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem flake-utils.lib.allSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };

        hello = pkgs.callPackage ./packages/hello { };

      in

      {
        packages = {
          hello = hello;
        };
      }
    );
}

