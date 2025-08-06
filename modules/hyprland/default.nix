{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
}
