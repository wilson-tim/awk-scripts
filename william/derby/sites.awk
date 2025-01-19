BEGIN {
  line_no = 1
  while ( (getline < "site_code.lst") > 0) {
    sites[line_no] = $1
    line_no++
  }
}

{
  print sites[NR], $1
}

END {}
