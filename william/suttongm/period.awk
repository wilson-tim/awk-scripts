BEGIN { 
  FS="|"; OFS=","
  contractRef = "GM"
  firstLine = "true"
  featureChange = "false"; itemChange = "false"
  currentFeatureRef = ""; currentItemRef = ""
  lastPeriod = ""
}

function repeat(repeatString, repeatTimes, _line) {
  for(i=1; i<= repeatTimes; i++) {
    _line = _line repeatString
  }
  return _line
}

function print_period(period) {
  if(lastPeriod == "") {
    # First period found
    return repeat(",", (int(period) - 1)) "," "1"
  } else {
    # There was a previous period found
    if(int(period) == (int(lastPeriod) + 1)) {
      return "," "1"
    } else {
      return repeat(",", (int(period) - int(lastPeriod)) - 1 ) "," "1"
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

$1 == contractRef {
  if(featureChange == "true" || itemChange == "true") {
    # only do if not the first line of the file
    if(firstLine == "false"){
      # finish off the line
      printf repeat(",", (13 - int(lastPeriod)))
      lastPeriod = ""
      print ""
    } else {
      print "Feature", "Item", "Period1", "Period2", "Period3", "Period4", "Period5", "Period6", "Period7", "Period8", "Period9", "Period10", "Period11", "Period12", "Period13"
      firstLine = "false"
    }

    # Start new line
    printf $2 "," $3 print_period($4)

    lastPeriod = $4
    if(featureChange == "true") { featureChange = "false"}
    if(itemChange == "true") { itemChange = "false"}
  } else {
    # continue previous line
    printf print_period($4)
    lastPeriod = $4
  }
}

END {
  print ""
}
