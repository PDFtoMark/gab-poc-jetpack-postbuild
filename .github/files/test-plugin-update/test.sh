#!/usr/bin/env bash
# Stand-in for WordPress' "wp plugin install --activate": installs each built
# plugin zip and loads its main PHP file, exactly what WP does on activation.
set -eo pipefail
ZIPDIR="$GITHUB_WORKSPACE/zips"
PLUGINDIR=/tmp/wp-plugins
mkdir -p "$PLUGINDIR"
cd "$ZIPDIR"
for ZIP in *-dev.zip; do
	SLUG="${ZIP%-dev.zip}"
	echo "== installing plugin $SLUG from $ZIP"
	unzip -q -o "$ZIP" -d "$PLUGINDIR"
	php "$PLUGINDIR/$SLUG/$SLUG.php"
done
