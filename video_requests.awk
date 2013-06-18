BEGIN {
  mp4 = hls = webm = ogg = 0;
  print "{"
  print "  \"requests\": ["
}

{
    gsub(/\\N/, "\"\\n\"")
}

/"video\/mp4"/ {
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

/\.ogv/ {
  ogg++
  print "    [", $0, "],"
}

END {
  print "  ],"
  print "  \"stats\": {"
  print "    \"mp4\":", mp4, ","
  print "    \"m3u8\":", hls, ","
  print "    \"webm\":", webm, ","
  print "    \"ogg\":", ogg
  print "  }"
  print "}"
}
