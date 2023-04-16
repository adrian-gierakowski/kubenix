{
  lib,
  runtimeShell,
  skopeo,
  writeScript,
}:
{
  copyDockerImages = {
    images,
    dest,
    args ? "",
  }:
    writeScript "copy-docker-images.sh" (lib.concatMapStrings
      (image: ''
        #!${runtimeShell}

        set -e

        echo "copying '${image.imageName}:${image.imageTag}' to '${dest}/${image.imageName}:${image.imageTag}'"
        ${skopeo}/bin/skopeo copy ${args} $@ docker-archive:${image} ${dest}/${image.imageName}:${image.imageTag}
      '')
      images);
}
