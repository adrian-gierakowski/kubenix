{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  docker = pkgs.callPackage ../../lib/docker {};
  inherit (config) testing;

  allImages = unique (flatten (map (t: t.evaled.config.docker.export or []) testing.tests));

  cfg = config.testing.docker;
in {
  options.testing.docker = {
    registryUrl = mkOption {
      description = "Docker registry url";
      type = types.str;
    };

    images = mkOption {
      description = "List of images to export";
      type = types.listOf types.package;
    };

    copyScript = mkOption {
      description = "Script to copy images to registry";
      type = types.package;
    };
  };

  config.testing.docker = {
    images = allImages;

    copyScript = docker.copyDockerImages {
      inherit (cfg) images;
      dest = "docker://" + cfg.registryUrl;
    };
  };

  config.testing.common = [
    {
      features = ["docker"];
      options = {
        _file = "testing.docker.registryUrl";
        docker.registry.url = cfg.registryUrl;
      };
    }
  ];
}
