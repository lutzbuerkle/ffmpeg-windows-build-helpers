#!/bin/bash

# docker actually runs this as a script after having copied it in as part of the "big initial copy" making the image...

set -e

shopt -s extglob

OUTPUTDIR=/output
INPUTDIR=./sandbox/win64/ffmpeg_git

./cross_compile_ffmpeg.sh --ffmpeg-git-checkout-version=master --build-ffmpeg-shared=y --build-ffmpeg-static=y --disable-nonfree=n --build-intel-qsv=y --compiler-flavors=win64 --enable-gpl=y

INPUTDIR+=?(_with_fdk_aac)?(_xp_compat)?(_lgpl)
INPUTDIR+=?(@(_release_|_n)+([0-9.])?(-dev))

mkdir -p $OUTPUTDIR/static/bin
cp -R -f $INPUTDIR/ffmpeg.exe $OUTPUTDIR/static/bin
cp -R -f $INPUTDIR/ffprobe.exe $OUTPUTDIR/static/bin
cp -R -f $INPUTDIR/ffplay.exe $OUTPUTDIR/static/bin

mkdir -p $OUTPUTDIR/shared
cp -R -f ${INPUTDIR}_shared/bin/ $OUTPUTDIR/shared

if [[ -f /tmp/loop ]]; then
  echo 'sleeping forever so you can attach to this docker if desired' # without this if there's a build failure the docker exits and can't get in to tweak stuff??? :|
  sleep
fi
