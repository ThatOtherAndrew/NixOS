{
  description = "Nix(OS) configuration files for those with mediocre expectations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tsutsumi = {
      url = "github:Fuwn/tsutsumi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    infinidesk = {
      url = "github:ThatOtherAndrew/Infinidesk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    vars = import ./variables.nix;
  in {
    nixosConfigurations = {
      nova = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nova
        ];
        specialArgs = { inherit inputs vars; };
      };
    };
  };
}
