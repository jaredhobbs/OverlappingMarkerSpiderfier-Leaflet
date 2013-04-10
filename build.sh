#!/bin/bash
INDIR=./
INPREFIX=oms

OUTDIR=./tmp/
OUTNAME=${INPREFIX}.min.js
OUTFILE=${OUTDIR}${OUTNAME}

coffee --output $OUTDIR --compile ${INDIR}${INPREFIX}.coffee

java -jar /usr/local/closure-compiler/compiler.jar \
  --js ${OUTDIR}${INPREFIX}.js \
  --output_wrapper '(function(){%output%}).call(this);' \
> $OUTFILE

echo '/*' $(date) '*/' >> $OUTFILE

git checkout gh-pages
cp $OUTFILE bin/
cp ${OUTDIR}${INPREFIX}.js bin/
git commit -a -m 'Updated build'
git checkout master
