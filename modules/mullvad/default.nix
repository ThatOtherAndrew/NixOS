{ vars, pkgs, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
