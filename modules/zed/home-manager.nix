{ pkgs, inputs, ... }:

{
  home.shell.enableShellIntegration = true;

  home.packages = with pkgs; [
    nil
    nixd
    package-version-server
    zed-editor
    inputs.tsutsumi.packages.${stdenv.hostPlatform.system}.wakatime-ls
  ];

  home.shellAliases = {
    zed = "zeditor";
  };
}
