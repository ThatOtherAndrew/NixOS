{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris  # Game launcher
    olympus  # Celeste mod manager
    (tetrio-desktop.override { withTetrioPlus = true; })
  ];
}
