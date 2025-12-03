{
  description = "Flake for Advent of Code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.beam28Packages.elixir_1_19
        ];
      };

    };
}
