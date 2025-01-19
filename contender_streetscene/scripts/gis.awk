/^$/ {next}
{ 
  $0 = toupper($0)
  print $0 "|"
}
