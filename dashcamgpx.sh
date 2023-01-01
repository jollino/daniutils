#!/bin/bash

# gpx.fmt => https://github.com/exiftool/exiftool/blob/master/fmt_files/gpx.fmt

for f in *MP4; do exiftool -ee -p gpx.fmt $f > $f.gpx 2>/dev/null; done
for f in *gpx; do uniq $f > tmp ; mv tmp $f; done
for f in *gpx; do sed "9d" $f > tmp; mv tmp $f; done
for f in *gpx; do sed -E "s/([0-9]{4}):([0-9]{2}):([0-9]{2}) /\\1-\\2-\\3T/g" $f > tmp; mv tmp $f; done
for f in *gpx; do cat $f | php -R 'echo preg_replace_callback("/<speed>(\d+)/", function($m) { return "<speed>" . $m[1]/3.6; }, $argn) . "\n";' > tmp; mv tmp $f; done
# nextbase # for f in *gpx; do cat $f | php -R 'echo preg_replace_callback("/<speed>(\d+\.?\d*)/", function($m) { return "<speed>" . $m[1]/3.6; }, $argn) . "\n";' > tmp; mv tmp $f; done
param=""; for f in *gpx; do param="$param -f $f"; done; gpsbabel -i gpx $param -o gpx -x track,merge,discard -F tutto.gpx
