#!/bin/bash
OUTPUT="readme.md" 

read -r -d '' style<< 'EOF'
Repository to hold my web dev shenanigans.

## pages

EOF

printf "%s" "$style" > $OUTPUT
echo >>  $OUTPUT
for i in `find . -name '*.html'`; do
  fname=`basename $i`
  echo "- [$fname]($i)" >> $OUTPUT
done