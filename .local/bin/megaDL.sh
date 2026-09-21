#!/bin/sh

set -e

LINKS="$1"
MEGAPATH="$2"

cat "$LINKS" | xargs -I{} -r -d '\n' megadl --path="$MEGAPATH" {}
