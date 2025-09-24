{ pkgs, ... }:

{
  home.packages = with pkgs; [
    uv
    ruff
    ty
  ];
}
