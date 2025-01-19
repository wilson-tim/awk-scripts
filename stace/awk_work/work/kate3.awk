BEGIN {}

NR < 12 || NR > 4772 {next}
$1 == "FINANCIAL" {next}
$1 == "DATE" {next}
$1 == "Man." {next}
$1 == "Unit" {next}
/--+/ {next}

$1 == "REV" && $6 > 0 {
  print $6,$7,$9,$10,$11,$12
  next
}
  
$1 != "REV" && $4 > 0 {
  print $4,$5,$7,$8,$9,$10
  next
}

END {}