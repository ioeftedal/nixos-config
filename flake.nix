{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-25.05;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              ghostty = nixpkgs-unstable.legacyPackages.${prev.system}.ghostty;
            })
          ];
        }
      ];
    };
  };
}
