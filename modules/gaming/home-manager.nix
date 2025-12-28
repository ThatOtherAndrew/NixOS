{ pkgs, ... }:

{
  home.packages = with pkgs; [
    olympus  # Celeste mod manager
    # (tetrio-desktop.override { withTetrioPlus = true; })
    tetrio-desktop  # tetrio-plus currently broken
  ];

  programs.lutris.enable = true;  # Game launcher
}
