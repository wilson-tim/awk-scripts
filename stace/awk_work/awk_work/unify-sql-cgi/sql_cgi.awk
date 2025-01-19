# Takes input from stdin
# The input should be an sql statement
BEGIN {
   # Additional SQL commands to be run BEFORE the user supplied command
   print "lines 0;" > "sql_cgi.tmp1" }

# For each line of in put print it to the file, if the line is the last line,
# i.e. there is a pattern /;$/ in the input, then add the ouput filename.
{
   sub(/;$/," into 'sql_cgi.tmp2';")
   print $0 > "sql_cgi.tmp1" }

# If the last line then exit.
/;$/ { 
   exit }

END {
   # Close the temp file
   close("sql_cgi.tmp1")

   # Print out each line of the output
   if (system("sql -q -r sql_cgi.tmp1") == 0) {
      while ( (getline < "sql_cgi.tmp2") > 0 ) {
         print ">> " $0 }
      close("sql_cgi.tmp2")
      system("rm sql_cgi.tmp2") } }

