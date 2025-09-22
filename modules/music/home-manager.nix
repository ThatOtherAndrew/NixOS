{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwig-studio
    reaper
    yabridge
    yabridgectl
  ];
}
