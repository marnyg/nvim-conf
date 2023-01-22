{
  description = "An example of neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-flake.url = "github:neovim/neovim?dir=contrib";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vim-extra-plugins = {
      url = "github:m15a/nixpkgs-vim-extra-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, neovim-flake, vim-extra-plugins, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      #flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        overlays = [ inputs.neovim-nightly-overlay.overlay ];
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = import ./flakeUtils/shell.nix { inherit pkgs; };
        checks = import ./flakeUtils/checks.nix { inherit pkgs; };
        formatter = pkgs.nixpkgs-fmt;
        packages.default = import ./nix/newnvim.nix { inherit pkgs; neovim = pkgs.neovim; };
        apps.default = flake-utils.lib.mkApp {
          drv = import ./nix/newnvim.nix { inherit pkgs; neovim = pkgs.neovim; };
          name = "nvim";
        };
        #packages.test =  pkgs.callPackage  ./test.nix {};
      }


    );
}
