{
  lib,
  remarshal,
  runCommand,
}:
path:
  lib.importJSON (runCommand "yaml-to-json" {} ''
    ${remarshal}/bin/remarshal -i ${path} -if yaml -of json > $out
  '')