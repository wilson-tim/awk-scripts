BEGIN{
  FS=","; OFS=","
  
  # parse the keys file for the new key info.
  file = "../species04.csv"
  while ( (getline < file) > 0 ) {
    keys[$2] = $1
  }
  close(file)
}

{
  # replace the old key (column number) with the new numeric value 
  $4 = keys[$4]
  print $0
}

END{}
