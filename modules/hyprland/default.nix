{ vars, pkgs, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  nix.settings = {
    extra-substituters = [ "https://vicinae.cachix.org" ];
    extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # https://espanso.org/
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
  };
}
