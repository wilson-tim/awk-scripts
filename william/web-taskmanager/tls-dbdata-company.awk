BEGIN {}

$3 == "Company" {
  if(match($0, /VALUES \(.*\)/) ){
    values = substr($0,RSTART+7, RLENGTH)
    split(values, svalues, ",")
    company = svalues[1]; 
    gsub(/^\(/,"",company); 
    gsub(/'/,"",company); 
    print NR "|TASK|" company
  }
}

END {}
