BEGIN { 
  OFS=","
  savedFS=FS
  FS="|"
  while ( (getline < "tls-company.txt") > 0) {
    compcode[$3] = $1
  } 
  close("tls-company.txt")

  FS=savedFS
}

function print_field (field, sep) {
  gsub(/'/,"", field)
  gsub(/\|/,":", field)
  gsub(/\\"/,"'", field)
  gsub(/##quote##/,"'",field)
  return field sep
}

function format_date (date,  _date, _dd, _mm, _yyyy) {
  match(date, /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/)
  _date = substr(date,RSTART,RLENGTH)
  _yyyy = substr(_date,1,4)
  _mm = substr(_date,6,2)
  _dd = substr(_date,9,2)
  return _dd "/" _mm "/" _yyyy
}

function user_name (full_name,  _part1, _part2) {
  match(full_name, / /)
  _part1 = substr(substr(full_name,1, RSTART-1), 1, 5)
  _part2 = substr(substr(full_name,RSTART+1), 1, 5)
 return tolower(_part1 _part2)
}

$3 == "Tasks" {
  if(match($0, /VALUES \(.*\)/) ){
    # split the values into parts using commas, then stitch back together in correct parts
    values = substr($0,RSTART+8, RLENGTH-9)
    size = split(values, v, ", ")

    quotes = "false"
    line = ""
    for (i=1; i<size; i++) {
      item = v[i]
      #gsub(/\%/,"%%", item)
      gsub(/\\'/,"##quote##", item)
      if (item ~ /.*'$/) { quotes = "false"; line = line print_field(item,"|") } 
      else if (item ~ /^'.*/) { quotes = "true"; line = line print_field(item,", ") }
      else if (quotes == "true") { line = line print_field(item,", ") } 
      else { line = line print_field(item,"|") }
    }
    line = line print_field(v[size], "|")

    # Now split the values into there correct parts
    size = split(line, sv, "|")
    header = sv[6]
    headers[header] = header
    company[header] = sv[2]
    details[header] = details[header] " " sv[5]
    if(format_date(sv[3]) == "//") {
      date_started[header] = format_date(sv[4])
    } else {
      date_started[header] = format_date(sv[3])
    }
    date_ended[header] = format_date(sv[4])
    staff[header] = sv[7]
    bug[header] = sv[8]

  }
}

END {
  # the intial ticket_no will have to be got from the tls application before running
  ticket_no=31
  # status "b" equals "bug"
  # status "s" equals "support"
  
  for(item in headers) {
    if (bug[item] == 1) {
      status = "b"
    } else {
      status = "s"
    }

    # the ticket_header record
    user = user_name(staff[item])
    description = substr(headers[item], 1, 80)
    print "insert into ticket_header (ticket_no, status, ticket_type, group_1_key, group_2_key, group_3_key, group_4_key, group_5_key, group_6_key, group_7_key, group_8_key, group_9_key, description, logged_user, logged_date, logged_time_h, logged_time_m, opened_user, opened_date, opened_time_h, opened_time_m, closed_reason, closed_user, closed_date, closed_time_h, closed_time_m, owner, owner_flag) values ("
    if (date_ended[item] != "//") {
      print ticket_no, "\"" status "\"", "\"TASK\"", "\"" compcode[company[item]] "\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"" description "\"", "\"" user "\"", "\"" date_started[item] "\"", "\"09\"", "\"00\"", "\"" user "\"", "\"" date_started[item] "\"", "\"09\"", "\"00\"", "\"Transferred into TLS\"", "\"" user "\"", "\"" date_ended[item] "\"", "\"09\"", "\"00\"", "\"" user "\"", "\"N\""
    } else {
      print ticket_no, "\"" status "\"", "\"TASK\"", "\"" compcode[company[item]] "\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"\"", "\"" description "\"", "\"" user "\"", "\"" date_started[item] "\"", "\"09\"", "\"00\"", "\"" user "\"", "\"" date_started[item] "\"", "\"09\"", "\"00\"", "\"\"", "\"\"", "null", "\"\"", "\"\"", "\"" user "\"", "\"N\""
    }
    print ");"

    # the ticket_line record(s)
    det = "[" headers[item] "] " details[item]
    lines = int(length(det)/250) + 1
    for (line=1; line<=lines; line++) {
      text = substr(det, ((line-1)*250)+1, 250)    
      print "insert into ticket_line (ticket_no, seq_no, image_url, text, logged_user, logged_date, logged_time_h, logged_time_m) values ("
      print ticket_no, line, "\"\"", "\"" text "\"", "\"" user "\"", "\"" date_started[item] "\"", "\"09\"", "\"00\""
      print ");"
    }

    ticket_no++
  }
}
