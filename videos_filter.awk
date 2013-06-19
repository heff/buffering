# usage: awk -f video_filter.awk [file ...]

BEGIN {
  count = 0
}

/\.(mp4|m3u8|webm|ogv|ogg|flv|f4v|mov|m4v|avi|wmv)[?"]/ {
  count++
  match($0, /\.(mp4|m3u8|webm|ogv|ogg|flv|f4v|mov|m4v|avi|wmv)[?"]/)
  formats[substr($0, RSTART + 1, RLENGTH - 2)]++
  print $0
}

END {
  print "---"
  print count
  for (format in formats) {
    print format, formats[format]
  }
}
