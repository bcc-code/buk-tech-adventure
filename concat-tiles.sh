#!/bin/bash
# Usage ./concat-tiles.sh TILELIST [TILESETNAME]
#
# Concatenate all tiles from the tilelist in order in a single 12 tiles wide column
# You might have to remove the 16kP file height limit in /etc/ImageMagick-6/policy.xml to do this.
# Otherwise you might receive an error like:
#   montage-im6.q16: width or height exceeds limit `../kenney_sketch-desert.png' @ error/cache.c/OpenPixelCache/3909.

cd $(dirname $1)
montage $(cat $(basename $1)) -mode concatenate -background none -tile 16x "${2:-$(basename $1).png}"
cd -
