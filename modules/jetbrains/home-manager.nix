{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea
    jetbrains.pycharm
    jetbrains.webstorm

    # Useful for PyCharm
    uv
    ruff
    ty
  ];
}
