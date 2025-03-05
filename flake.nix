{
  description = "A lightweight PoC web framework for rust.";
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs?rev=a47b881e04af1dd6d414618846407b2d6c759380";
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
            pkgs.nodejs
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
