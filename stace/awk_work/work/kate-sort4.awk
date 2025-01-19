BEGIN {}

{
  b[$1] = $1
  a[$1, "com"] = a[$1 , "com"] + $5
  a[$1, "exp"] = a[$1 , "com"] + $6
}

END {
  for (i in b) {
    print i, a[i, "com"], a[i, "exp"]
  }
}