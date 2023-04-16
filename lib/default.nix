{
  callPackage,
  lib,
}: {
  k8s = callPackage ./k8s {};
  docker = callPackage ./docker {};
  helm = callPackage ./helm {};
}
