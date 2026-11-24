#!/bin/bash
set -euxo pipefail

PLATFORM_DIR="$PWD"
SPEC="$PLATFORM_DIR/package/spectra-bin.spec"
METAINFO="$PLATFORM_DIR/package/io.github.luinbytes.spectra.metainfo.xml"

# version_after is exported by the bump-platform action.
: "${version_after:?Missing core version from bump-platform}"
sed -Ei "s/^(%define version ).*/\1$version_after/" "$SPEC"

RELEASE_DATE=$(date +%Y-%m-%d)
sed -Ei 's/(<release version=")(.*)(" date=")(.*)(" \/>)/'"\1$version_after\3$RELEASE_DATE\5/" "$METAINFO"

git add -u "$SPEC" "$METAINFO"
