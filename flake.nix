{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
      nixpkgs,
      flake-utils,
      ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # it is not necessary to override package args in a overlay, when
          # nothing else depends on the package
          # overlays = [
          #   (self: super: {
          #     # change the platform from PM3RDV4 to PM3GENERIC (proxmark3 easy)
          #     # https://github.com/NixOS/nixpkgs/blob/nixos-22.11/pkgs/tools/security/proxmark3/proxmark3-rrg.nix#L33
          #     proxmark3-rrg = super.proxmark3-rrg.override {hardwarePlatform = "PM3GENERIC";};
          #   })
          # ];
        };

      in {
        devShell = pkgs.mkShell {
          name = "proxmark3-rrg shell";
          buildInputs = with pkgs; [
            (proxmark3-rrg.override { hardwarePlatform = "PM3GENERIC";})
          ];
          shellHook = ''
        '';
        };
      });
}
