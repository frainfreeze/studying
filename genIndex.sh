#!/bin/bash
OUTPUT="readme.md" 
echo "# html pages" > $OUTPUT

for i in `find . -name '*.html'`; do
  fname=`basename $i`
  echo "- [$fname]($i)" >> $OUTPUT
done