{ pkgs, ... }:

{
  home.packages = with pkgs; [
    olympus  # Celeste mod manager
  ];
}
