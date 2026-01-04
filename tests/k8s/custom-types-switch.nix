{ config, lib, kubenix, ... }:
with lib;
{
  imports = with kubenix.modules; [ k8s ];

  kubernetes.version = "1.24";

  kubernetes.customTypesModuleDefinesCRDSpec = false;

  kubernetes.customTypes = [
    {
      group = "example.com";
      version = "v1";
      kind = "FlexibleResource";
      attrName = "flexibleResource";
      module = {
        options.spec = mkOption {
          type = types.attrs;
          default = {};
        };
        options.status = mkOption {
           type = types.str;
           default = "";
        };
      };
    }
  ];

  kubernetes.resources.flexibleResource.test = {
      spec.foo = "bar";
      status = "active";
  };
}
