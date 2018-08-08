#!/bin/bash

ROOT=$(pwd)/projects
HTTP="/"
OUTPUT="index.html" 

i=0
read -r -d '' style<< 'EOF'
<style>
ul {
  padding: 0;
  margin: 0;
  list-style-type: none;
  position: relative;
}
li {
  list-style-type: none;
  border-left: 2px solid #000;
  margin-left: 1em;
}
li div {
  padding-left: 1em;
  position: relative;
}
li div::before {
  content:'';
  position: absolute;
  top: 0;
  left: -2px;
  bottom: 50%;
  width: 0.75em;
  border: 2px solid #000;
  border-top: 0 none transparent;
  border-right: 0 none transparent;
}
ul > li:last-child {
  border-left: 2px solid transparent;
}
</style>

EOF
printf "%s" "$style" > $OUTPUT
echo "<ul>" >> $OUTPUT
for filepath in `find "$ROOT" -maxdepth 1 -mindepth 1 -type d| sort`; do
  path=`basename "$filepath"`
  echo "  <li><div>$path</div></li>" >> $OUTPUT
  echo "  <ul>" >> $OUTPUT
  for i in `find "$filepath" -maxdepth 1 -mindepth 1 -type f| sort`; do
    file=`basename "$i"`
    echo "    <li><div><a href=\"/web-dev/projects/$path/$file\">$file</a></div></li>" >> $OUTPUT
  done
  echo "  </ul>" >> $OUTPUT
done
echo "</ul>" >> $OUTPUT