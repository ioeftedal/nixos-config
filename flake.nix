{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-25.05;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    catppuccin.url = github:catppuccin/nix/release-25.05;
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    catppuccin, 
    ...
  }: {
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix

        catppuccin.nixosModules.catppuccin
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
