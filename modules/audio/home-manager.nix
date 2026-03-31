{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwig-studio
    crosspipe
    reaper
    # yabridge
    # yabridgectl
  ];
}
