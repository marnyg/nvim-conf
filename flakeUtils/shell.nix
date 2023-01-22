{ nixpkgs, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
in
{
  "${system}".default = pkgs.mkShell {
    buildInputs = [
      pkgs.nixpkgs-fmt
      pkgs.selene
      pkgs.stylua
      pkgs.pre-commit
      #pkgs.lazygit
    ];
  };
}
