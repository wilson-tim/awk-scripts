BEGIN {}

$1 == "FINANCIAL" {next}
$1 == "DATE" {next}

$1 == "Man." {
  print ""
  print $0
  next
}

$1 == "Unit" {
  print $0
  next
}

/--+/ {
  print $0
  next
}

$1 == "REV" && $6 > 0 {
  print $0
  next
}
  
$1 != "REV" && $4 > 0 {
  print $0
  next
}

END {}