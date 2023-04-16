{
  lib,
  remarshal,
  runCommand,
}:
name:
documents:
  runCommand name {}
  (lib.concatMapStringsSep "\necho --- >> $out\n"
    (
      d: "${remarshal}/bin/remarshal -i ${builtins.toFile "doc" (builtins.toJSON d)} -if json -of yaml >> $out"
    )
    documents)