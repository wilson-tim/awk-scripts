BEGIN{
  FS=","; OFS=","
  
  # parse the keys file for the new key info.
  file = "../species04.csv"
  while ( (getline < file) > 0 ) {
    usrn[$1] = $2
    uprn[$3] = $1
  }
  close(file)
}

{
  print $1 usrn[$1] uprn[$1]
}

END{}
