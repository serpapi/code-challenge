let
  src = builtins.fetchGit {
    name = "nixpkgs-unstable-20.09pre237891.f9eba87bf03";
    url = "https://github.com/nixos/nixpkgs-channels/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "f9eba87bf03318587df8356a933f20cfbc81c6ee";
    };
  pkgs = import src {};

  lib = pkgs.haskell.lib;
  compiler = "ghc884";
  ghc = pkgs.haskell.packages.${compiler}.override {
      overrides = self: super: {
      };
    };

  tools = with ghc; [ cabal-install ];

  overrideCabal = pkg: pkgs.haskell.lib.overrideCabal pkg
    ({buildDepends ? [], ...}: {
      buildDepends = buildDepends ++ tools;
    });
  cabal2nixResult = url: pkgs.runCommand "cabal2nixResult" {
    buildCommand = ''
      cabal2nix --no-check --jailbreak --no-haddock ${url} > $out
    '';
    buildInputs = [ pkgs.cabal2nix ];
  } "";
  cabal2nixResultLocal = path: cabal2nixResult "file://${path}";
  package = ghc.callPackage (cabal2nixResultLocal ./.) {};
  drv = overrideCabal package;

in if pkgs.lib.inNixShell then drv.env else drv
