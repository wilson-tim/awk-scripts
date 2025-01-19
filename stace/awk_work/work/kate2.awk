BEGIN {}

$1 == "FINANCIAL" {next}
$1 == "DATE" {next}
$1 == "Man." {next}
$1 == "Unit" {next}
/--+/ {next}

$1 == "REV" && $6 > 0 {
  a[$6 " " NR] = $7 " " $9 " " $10 " " $11 " " $12
  next
}
  
$1 != "REV" && $4 > 0 {
  a[$4 " " NR] = $5 " " $7 " " $8 " " $9 " " $10
  next
}

END {
  for(i in a) {
    print a[i]
  }
}