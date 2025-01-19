BEGIN {
  usage = "Usage:\nawk -f sql.awk -v SQL=\"<non unload sql statement>\""

  if (SQL ~ /unload to/) {
    print "USAGE ERROR:"
    print "SQL 'UNLOAD' statements not allowed."
    print usage
    exit
  } else if (SQL == "") {
    print "USAGE ERROR:"
    print "Blank SQL statements not allowed."
    print usage
    exit
  } else {
    temp_file = "awk_sql.tmp"
    cmd = "sql 2>/dev/null"
    print "unload to '" temp_file "' " SQL | cmd 
    close(cmd)

    while (getline < temp_file) {
      print $0
    } 

    close(temp_file)
    system("rm " temp_file " 2>/dev/null")
  }
}

END {}
