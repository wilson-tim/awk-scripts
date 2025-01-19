BEGIN{
  FS=","
  
  # parse the keys file for the new key info.
  file = "awkusup01.csv"
  while ( (getline < file) > 0 ) {
    usrn[$1] = $2
    uprn[$1] = $3
  }
  close(file)
}

{
  print ($1 "," usrn[$1] "," uprn[$1]) > "site.out"
}

END{}
