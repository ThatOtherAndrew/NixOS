{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  fonts.enableDefaultPackages = true;
}
