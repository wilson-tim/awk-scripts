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
    temp_file2 = "awk_sql.sql"
    print "unload to '" temp_file "'" SQL > temp_file2
    cmd = "sql " temp_file2 " 2>/dev/null"
    system(cmd)
    close(cmd)

    while (getline < temp_file) {
      print $0
    } 

    close(temp_file)
    close(temp_file2)
    system("rm " temp_file " 2>/dev/null")
    system("rm " temp_file2 " 2>/dev/null")
  }
}

END {}
