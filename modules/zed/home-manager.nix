{ inputs, vars, pkgs, ... }:

{
  home.shell.enableShellIntegration = true;

  home.packages = with pkgs; [
    nil
    package-version-server
    zed-editor
    inputs.tsutsumi.packages.${system}.wakatime-ls
  ];

  home.shellAliases = {
    zed = "zeditor";
  };
}
