{
  remarshal,
  runCommand,
  writeText,
}:
config:
  # NOTE: this is IFD
  builtins.readFile (runCommand "to-yaml" {} ''
    ${remarshal}/bin/remarshal -i ${writeText "to-json" (builtins.toJSON config)} -if json -of yaml > $out
  '')