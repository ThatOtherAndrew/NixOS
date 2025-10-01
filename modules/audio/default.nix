{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  musnix = {
    enable = true;

    # Install realtimeconfigquickscan
    rtcqs.enable = true;
  };
}
