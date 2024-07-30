{
   inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";

   outputs = { self, nixpkgs }:
   let
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; };
   in {
      packages.${system}.default = pkgs.callPackage ./default.nix {};
      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
   };
}
