BEGIN {}
$0 !~ /unload to/ {
   temp_file = "awk_sql.tmp"
   cmd = "sql 2>/dev/null"
   print "unload to '" temp_file "' " $0 | cmd 
   close(cmd)

   while (getline < temp_file) {
     print $0
   } 

   close(temp_file)
}

$0 ~ /unload to/ {
  print "USAGE ERROR:"
  print "SQL 'UNLOAD' statements not allowed."
  exit
}
END {}
