BEGIN { 
  FS="|"; OFS=","
  contractRef = "GM"
  firstLine = "true"
  featureChange = "false"; itemChange = "false"; weekChange = "false"
  currentFeatureRef = ""; currentItemRef = ""; currentWeek = "";
  lastDay = ""
}

function repeat(repeatString, repeatTimes, _line) {
  for(i=1; i<= repeatTimes; i++) {
    _line = _line repeatString
  }
  return _line
}

# From a string of "XXXXXXX" get the day num 1 = Monday, 7 = Sunday, the letter "A" represents the day
# e.g. "XXAXXXX" is 3 or Wednesday.
function day_num(occurDay) {
  return index(occurDay, "A")
}

function print_day(occurDay) {
  if(lastDay == "") {
    # First day found
    if(occurDay == "") {
      return ""
    } else {
      return repeat(",", (day_num(occurDay) - 1)) "," "1"
    }
  } else {
    # There was a previous period found
    if(day_num(occurDay) == (day_num(lastDay) + 1)) {
      return "," "1"
    } else {
      return repeat(",", (day_num(occurDay) - day_num(lastDay)) - 1 ) "," "1"
    }
  }
}

# Feature change
$2 != currentFeatureRef {
  featureChange = "true"
  currentFeatureRef = $2
}

# Item change
$3 != currentItemRef {
  itemChange = "true"
  currentItemRef = $3
}

# Week change
$4 != currentWeek {
  weekChange = "true"
  currentWeek = $4
}

$1 == contractRef {
  if(featureChange == "true" || itemChange == "true" || weekChange == "true") {
    # only do if not the first line of the file
    if(firstLine == "false"){
      # finish off the line
      printf repeat(",", (7 - day_num(lastDay)))
      lastDay = ""
      print ""
    } else {
      print "Feature", "Item", "Week", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
      firstLine = "false"
    }

    # Start new line
    printf $2 "," $3 "," $4 print_day($5)

    lastDay = $5
    if(featureChange == "true") { featureChange = "false"}
    if(itemChange == "true") { itemChange = "false"}
    if(weekChange == "true") { weekChange = "false"}
  } else {
    # continue previous line
    printf print_day($5)
    lastDay = $5
  }
}

END {
  # finish off the line
  printf repeat(",", (7 - day_num(lastDay)))
  lastDay = ""
  print ""
}
