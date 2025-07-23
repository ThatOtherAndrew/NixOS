{ vars, pkgs, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = ''
        -forcedesktopscaling 1.5
      '';
    };
  };
}
