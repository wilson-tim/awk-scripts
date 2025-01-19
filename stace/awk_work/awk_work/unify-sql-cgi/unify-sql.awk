# This file contains awk functions to interface into a Unify database.
# Local variables are prefixed with the underscore character e.g. _local

BEGIN {}

function database(_open_closed, _database, # Arguments
                  _call, _call_out, _call_err ) { # Local Variables

   # This is the name of the temp file
   _call_out = "unify-database.tmp"
   _call_err = "unify-database-err.tmp"

   if (tolower(_open_closed) == "open" && _database != "") {
      # This sets up the call
      _call = "DBPATH=" _database ";export DBPATH;$UNIFY/../bin/startdb > " _call_out " 2> " _call_err

      # This section runs the call and then closes it and the associated
      # file that it opened
      system(_call) }
   else if (tolower(_open_closed) == "close" && _database != "") {
      # This sets up the call
      _call = "DBPATH=" _database ";export DBPATH;$UNIFY/../bin/shutdb > " _call_out " 2> " _call_err

      # This section runs the call and then closes it and the associated
      # file that it opened
      system(_call) }
   
   # Close the opened files.
   close(_call_out)
   close(_call_err) }


function sql(_sql_statement, _database, # Arguments
             _pipe, _pipe_out, _pipe_err ) { # Local Variables
   
   # This is the name of the temp file
   _pipe_out = "unify-sql.tmp"
   _pipe_err = "unify-sql-err.tmp"

   if (_sql_statement != "" && _database != "") {
      # This sets up the pipe
      _pipe = "sql -q -d " _database " > " _pipe_out " 2> " _pipe_err
      
      # This section runs the pipe and then closes it and the associated
      # file that it opened
      print _sql_statement | _pipe
      #close(_pipe)
      close(_pipe_out)
   } }


function print_sql() {
   while ( (getline < "unify-sql.tmp") > 0) {
      #if ($0 !~ /sql>/) {
         print $0
  } }

