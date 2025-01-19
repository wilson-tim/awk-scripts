BEGIN { OFS="|" }

function user_name (full_name,  _part1, _part2) {
  match(full_name, / /) 
  _part1 = substr(substr(full_name,1, RSTART-1), 1, 5)
  _part2 = substr(substr(full_name,RSTART+1), 1, 5)
 return tolower(_part1 _part2)
}

$3 == "Tasks" {
  if(match($0, /VALUES \(.*\)/) ){
    values = substr($0,RSTART+7, RLENGTH)
    size = split(values, svalues, ",")
    staff = substr(svalues[size - 1], 2) 
    gsub(/'/,"",staff) 
    users[staff]=1
  }
}

END {
  for(item in users) {
    print user_name(item), user_name(item), item, "N", "N"
  }
}
