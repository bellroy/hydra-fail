{
  description = "Testing evaluation/build-time failures in Hydra";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = inputs: {
    packages = {
      x86_64-darwin.default =
        let np = import inputs.nixpkgs { system = "x86_64-darwin"; };
        in
        np.runCommandNoCC "x86_64-darwin-fail" {} ''
          false;
        '';
      x86_64-linux.default =
        let np = import inputs.nixpkgs { system = "x86_64-linux"; };
        in
        np.runCommandNoCC "x86_64-linux-fail" {} ''
          false;
        '';
    };

    hydraJobs = {
      x86_64-darwin = inputs.self.packages.x86_64-darwin.default;
      x86_64-linux = inputs.self.packages.x86_64-linux.default;
    };
  };
}
