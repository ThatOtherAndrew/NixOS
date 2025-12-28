{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.pycharm
    jetbrains.webstorm

    # Useful for PyCharm
    uv
    ruff
    ty
  ];
}
