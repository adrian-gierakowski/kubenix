{
  runCommand,
  coreutils,
}:
value:
  # NOTE: this is IFD
  builtins.readFile
  (runCommand "value-to-b64" {} "echo -n '${value}' | ${coreutils}/bin/base64 -w0 > $out")