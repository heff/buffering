# usage: awk -f video_requests.awk [file ...]

BEGIN {
  mp4 = hls = webm = ogv = flv = mov = m4v = avi = wmv = 0;
  print "{"
  print "  \"requests\": ["
}

{
    gsub(/\\N/, "\"\\n\"")
}

/\.mp4/ {
  mp4++
  print "    [", $0, "],"
}

/\.m3u8/ {
  hls++
  print "    [", $0, "],"
}

/"video\/webm"/ {
  webm++
  print "    [", $0, "],"
}

/\.ogv|\.ogg/ {
  ogv++
  print "    [", $0, "],"
}

/\.flv|\.f4v/ {
  flv++
  print "    [", $0, "],"
}

/\.mov/ {
  mov++
  print "    [", $0, "],"
}

/\.m4v/ {
  m4v++
  print "    [", $0, "],"
}

/\.avi/ {
  avi++
  print "    [", $0, "],"
}

/\.wmv/ {
  wmv++
  print "    [", $0, "],"
}

END {
  print "  ],"
  print "  \"stats\": {"
  print "    \"mp4\":", mp4, ","
  print "    \"m3u8\":", hls, ","
  print "    \"webm\":", webm, ","
  print "    \"ogg\":", ogv, ","
  print "    \"flv\":", flv, ","
  print "    \"mov\":", mov, ","
  print "    \"m4v\":", m4v, ","
  print "    \"avi\":", avi, ","
  print "    \"wmv\":", wmv, ","
  print "  }"
  print "}"
}
