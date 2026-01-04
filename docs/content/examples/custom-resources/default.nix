{ kubenix ? import ../../../.. }:
kubenix.evalModules.${builtins.currentSystem} {
  module = { ... }: {
    imports = [ ./module.nix ];

    kubenix.project = "custom-resources-example";
    kubernetes.version = "1.24";
  };
}
