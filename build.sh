#!/bin/sh

VERSION=0.5
BUILDSTAMP=$(date +%Y%m%dT%H%M)
BUILDDIR=vimpro-$VERSION-build${BUILDSTAMP}

mkdir -p $BUILDDIR/
cp -r src/ doc/ $BUILDDIR/
sed -i -e "s/%VERSIONSTAMP%/$VERSION/" -e "s/%DATESTAMP%/$(date '+%Y-%m-%d %H:%M')/g" $BUILDDIR/src/vimup.sh
tar cvzf ${BUILDDIR}.tar.gz $BUILDDIR/
rm -rf $BUILDDIR
