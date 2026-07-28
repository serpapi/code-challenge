{ pkgs, lib, config, inputs, ... }:

{
  languages.ruby = {
    enable = true;
    bundler.enable = true;
    versionFile = ./.ruby-version;
  };
}
