{
  description = "NixOS flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      forNixOsSystem = nixpkgs.lib.getAttrs [ "x86_64-linux" "aarch64-linux" ];

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });
    in
    {
      overlay = final: prev:
        let
          scriptPackage = name: { srcPath }: with final; stdenv.mkDerivation rec {
            pname = name;
            version = "1.0.0";
            src = ./.;

            installPhase = ''
              mkdir -p $out/bin
              cp ${srcPath} $out/bin/${name}
              chmod +x $out/bin/${name}
            '';
          };
        in {
          import-ssh-key = scriptPackage "import-ssh-key" {
            srcPath = ./tools/scripts/import-ssh-key.sh;
          };
        };

      
      # --------------------------------------------------
      #  Machine definitions
      # --------------------------------------------------

      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
            nixpkgs.overlays = [ self.overlay ];
          }
          ./hosts/nixos-vm
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.larusso = import ./home;
          }
        ];
      };

      nixosConfigurations.nixos-utm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
            nixpkgs.overlays = [ self.overlay ];
          }
          ./hosts/nixos-utm
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.larusso = import ./home;
          }
        ];
      };
      nixosConfigurations.ripper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [ self.overlay ];
          }
          ./hosts/ripper
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.larusso = import ./home;
          }
        ];
      };
    };
}
