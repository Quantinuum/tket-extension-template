{ pkgs, lib, inputs, config, ... }:
let
  pkgs-stable = import inputs.nixpkgs-2505 { system = pkgs.stdenv.system; };
in
{
  config = {
    # https://devenv.sh/packages/
    # on macos frameworks have to be explicitly specified
    # otherwise a linker error occurs on rust packages
    packages = [
      pkgs.just
      pkgs.cargo-nextest
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      pkgs.xz
    ];


    enterShell = ''
      cargo --version
    '';

    languages.python = {
      enable = true;
      uv = {
        enable = true;
        sync.enable = true;
      };
      venv.enable = true;
    };


    # https://devenv.sh/languages/
    # https://devenv.sh/reference/options/#languagesrustversion
    languages.rust = {
      channel = "stable";
      enable = true;
      components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
    };
  };
  # See full reference at https://devenv.sh/reference/options/
}
