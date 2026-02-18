{ inputs, pkgs, ... }:

let
  infinidesk = inputs.infinidesk.packages.${pkgs.system}.default;
in
{
  environment.systemPackages = [ infinidesk ];

  # Register Infinidesk as a selectable session in greetd/tuigreet
  services.displayManager.sessionPackages = [ infinidesk ];
}
