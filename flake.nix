{
  inputs = {
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    {
      darwinConfigurations."Rhelixa-Takuya-Fukujus-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [ ./configuration.nix ];
        specialArgs = { inherit inputs; };
      };
      darwinPackages = self.darwinConfigurations."Rhelixa-Takuya-Fukujus-MacBook-Pro".pkgs;
    };
}
