{
  description = "Validator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python312
            pkgs.uv 
          ];
          shellHook = ''
            if [ ! -d ".venv" ]; then 
              uv venv --python ${pkgs.python312}/bin/python; 
            fi
            source .venv/bin/activate
            uv sync
          '';
        };
      }
    );
}
