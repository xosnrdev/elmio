{
  description = "A lightweight PoC web framework for rust.";
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs?rev=de1864217bfa9b5845f465e771e0ecb48b30e02d";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.cargo-watch
            pkgs.cargo-sort
            pkgs.git-cliff
            pkgs.cargo-release
            pkgs.cargo-edit
            pkgs.cargo-dist
          ];
          shellHook = ''
            export RUST_BACKTRACE=1
          '';
        };
      in {
        formatter = pkgs.nixfmt-classic;
        devShells.default = devShell;
      });
}
