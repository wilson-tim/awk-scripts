BEGIN {
  SavedFS=FS
  FS="|"
  # Read the JIM info in
  while ( (getline < "rochford-1.csv") > 0) {
    # put each of the pieces of info into array's keyed on the uprn the 'S'
    gsub(/S/,"",$1)
    uprn[$1]=$1
    day[$1]=$4
    round[$1]=$5
    item1[$1]=$6
    item2[$1]=$7 
  }
  close("rochford-1.csv")

  FS=SavedFS
}

function occur_day (day) {
  if (day=="MON") {
    return "AXXXXXX"
  } else if (day=="TUES") {
    return "XAXXXXX"
  } else if (day=="WED") {
    return "XXAXXXX"
  } else if (day=="THUR") {
    return "XXXAXXX"
  } else if (day=="FRI") {
    return "XXXXAXX"
  } else {
    return ""
  }
}

function date_due (item, day) {
  if (day=="MON") {
    if (item=="REC-MIX-2") {
      return "'17/12/2007'"
    } else {
      return "'10/12/2007'"
    }
  } else if (day=="TUES") {
    if (item=="REC-MIX-2") {
      return "'18/12/2007'"
    } else {
      return "'11/12/2007'"
    }
  } else if (day=="WED") {
    if (item=="REC-MIX-2") {
      return "'19/12/2007'"
    } else {
      return "'12/12/2007'"
    }
  } else if (day=="THUR") {
    if (item=="REC-MIX-2") {
      return "'20/12/2007'"
    } else {
      return "'13/12/2007'"
    }
  } else if (day=="FRI") {
    if (item=="REC-MIX-2") {
      return "'21/12/2007'"
    } else {
      return "'14/12/2007'"
    }
  } else {
    return "null"
  }
}

{
  # First item/feature
  if (item1[$1]!="NO") {
    print "insert into si_i (item_ref, feature_ref, contract_ref, site_ref, allocation_r, priority_flag, volume, contract_value, occur_day, date_due, round_c, item_status) values ("
    print "'" item1[$1] "', '" item1[$1] "', 'REFUSE', '" $2 "', 'NONE', 'A', 1.00, 0.00, '" occur_day(day[$1]) "', " date_due(item1[$1], day[$1]) ", '" round[$1] "' , 'I'"
    print ");"
  }

  # Second item/feature
  if (item2[$1]!="NO") {
    print "insert into si_i (item_ref, feature_ref, contract_ref, site_ref, allocation_r, priority_flag, volume, contract_value, occur_day, date_due, round_c, item_status) values ("
    print "'" item2[$1] "', '" item2[$1] "', 'REFUSE', '" $2 "', 'NONE', 'A', 1.00, 0.00, '" occur_day(day[$1]) "', " date_due(item2[$1], day[$1]) ", '" round[$1] "' , 'I'"
    print ");"
  }
}

END {}
