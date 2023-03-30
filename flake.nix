{
  description = "An example of neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in
      {
        devShells = import ./flakeUtils/shell.nix { inherit pkgs; };
        checks = import ./flakeUtils/checks.nix { inherit pkgs; };
        formatter = pkgs.nixpkgs-fmt;

        # nix build .
        packages.default = import ./nix/newnvim.nix { inherit pkgs; };

        # nix run .
        apps.default = flake-utils.lib.mkApp {
          drv = import ./nix/newnvim.nix { inherit pkgs; };
          name = "nvim";
        };
        nixosModule = import ./nixosModule.nix;
        nixosModule2 = ./nixosModule.nix;
      }
    );

}
