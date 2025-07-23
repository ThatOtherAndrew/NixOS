{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = ''
        -forcedesktopscaling 1.5
      '';
    };
  };
}
