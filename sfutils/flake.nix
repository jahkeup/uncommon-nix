{
  description = "solarflare - sfutils";

  inputs = {
    nixpkgs.id = "nixpkgs";
    nixpkgs.ref = "nixos-unstable";
    nixpkgs.type = "indirect";

    sfutils-src.url = "https://www.xilinx.com/content/dam/xilinx/publications/solarflare/drivers-software/linux/misc/SF-105095-LS-68-linux-vmware-esx-utilities-source.zip";
    sfutils-src.flake = false;
  };

  outputs = { self, nixpkgs, sfutils-src }: let
    sfutils-build = { src = sfutils-src; version = "8.3.3.1000"; };
  in {
    packages.aarch64-linux.sfutils = nixpkgs.legacyPackages.aarch64.callPackage ./default.nix sfutils-build;
    packages.aarch64-darwin.sfutils = nixpkgs.legacyPackages.aarch64-darwin.callPackage ./default.nix sfutils-build;
    packages.x86_64-linux.sfutils = nixpkgs.legacyPackages.x86_64-linux.callPackage ./default.nix sfutils-build;

    packages.aarch64-darwin.default = self.packages.aarch64-darwin.sfutils;
    packages.aarch64-linux.default = self.packages.aarch64-linux.sfutils;
    packages.x86_64-linux.default = self.packages.aarch64-darwin.sfutils;
  };
}
