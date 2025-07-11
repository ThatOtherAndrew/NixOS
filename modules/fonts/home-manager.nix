{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    twemoji-color-font
    twitter-color-emoji
    unifont
    unifont_upper
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [];
      sansSerif = [];
      monospace = ["JetBrains Mono Nerd Font"];
      emoji = [];
    };
  };
}
