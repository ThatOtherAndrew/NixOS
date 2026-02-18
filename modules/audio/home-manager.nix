{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwig-studio
    helvum
    reaper
    # yabridge
    # yabridgectl
  ];
}
