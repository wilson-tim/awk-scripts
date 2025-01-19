BEGIN {}

NR > 1 {
  if (order != $1) {
    print "                    ----------------"
    print "                    " com, expn
    print ""
    
    print $0
    com = $5
    expn = $6
    order = $1
  } else {
    print $0
    com = com + $5
    expn = expn + $6
  }
}

NR == 1{
  print $0
  com = $5
  expn = $6
  order = $1
}

END {}