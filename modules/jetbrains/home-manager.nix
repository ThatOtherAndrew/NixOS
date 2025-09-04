{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.pycharm-professional
    jetbrains.webstorm

    # Useful for PyCharm
    uv
    ruff
    ty
  ];
}
