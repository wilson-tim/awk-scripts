BEGIN {
  FS="|"
}

{
  gsub(/S/,"",$1)
  print $1
}

END {}
