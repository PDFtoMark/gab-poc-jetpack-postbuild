#!/usr/bin/env bash
set -eo pipefail

mkdir work
mkdir zips

echo "::group::Creating $PLUGIN_SLUG-dev.zip"
mv "build/$PLUGIN_MIRROR" "work/$PLUGIN_SLUG"
touch "work/$PLUGIN_SLUG/ci-flag.txt"
(cd work && zip -r "../zips/${PLUGIN_SLUG}-dev.zip" "$PLUGIN_SLUG")
rm -rf "work/$PLUGIN_SLUG"
echo "::endgroup::"

# Mirrors the beta-plugin-slug lookup against the PR head checkout.
BETASLUG="$(jq -r '.extra["beta-plugin-slug"] // .extra["wp-plugin-slug"] // ""' "commit/$PLUGIN_SRC/composer.json")"
echo "BETASLUG=$BETASLUG"
