{ pkgs, ... }:

{
  home.packages = with pkgs; [
    olympus  # Celeste mod manager
    (tetrio-desktop.override { withTetrioPlus = true; })
  ];

  programs.lutris.enable = true;  # Game launcher
}
