BEGIN {}


# FUNCTION SECTION.
# -----------------
# This function creates an empty array.
function carray( _array) {   # Argumnets
   _array[1] = "create"
   darray(_array)
   return
}   

# This function deletes all elements from an array.
function darray( _array,   # Arguments
   _item ) {   # Local variables

   if ( ! is_empty(_array) ) {
      for (_item in _array) { delete _array[_item] }
   }
}

# This function checks whether an array is empty or not. Returns 1 if empty and
# 0 if their is any data.
function is_empty( _array,   # Arguments
   _item ) {   # Local variables

   # If finds any items then array is not blank
   for (_item in _array) { return 0 }

   # Array is blank
   return 1
}

# This function chops off leading, and trailing, spaces from a string.
function truncate( _string ) {   # Arguments
   sub(/^ +/,"",_string)
   sub(/ *$/,"",_string)
   return _string
}

# This function takes an sql statement and returns the results in an array -
# from the currently selected database.
# Used like ;
#    sql("select count(*) from activity;" "variable" VariableArray)
# The value returned is the number of lines returned by the sql statement.
# The "variable" list is a list of names, separated by spaces, which will be
# assigned the values from the last line of a select statement.
# The VariableArray holds the name:value pairing. Both the last two arguments
# are optional, but if the variable list is supplied then an array should be
# supplied to hold the results, otherwise the values will be lost. Make sure
# that the number of variables supplied is the same as the number returned
# from the SQL.
# This function sets three global variables;
# SqlOutput[] an array holding a numbered index of the sql statement output.
# SqlOutSz a numerical variable holding the size of the latest SqlOutput.
# SqlError[] an array holding a numbered index of the sql error output.
function sql( _sql_statement, _var_names, _array,   # Arguments
   _nr, _var_array, _var_array_sz, _sql_array, _sql_array_sz,  # Local Variables
   _count, _want_vars, _pipe_err, _pipe_out, _pipe) {   # Local variables

   # Setting up variables.
   SqlOutSz = 0
   _want_vars = "false"
   _pipe_out = "/u1/pharaoh/pharaoh_ds6/sqloutput.tmp"
   _pipe_err = "/u1/pharaoh/pharaoh_ds6/sqlerror.tmp"
 
   # Blank the error tmp file.
   print "" > _pipe_out
   print "" > _pipe_err

   # Create blank arrays
   carray(_array)
   carray(SqlOutput)
   carray(SqlError)
   
   # Create the pipe
   _pipe = "sql > " _pipe_out " 2> " _pipe_err

   # If the user wants variables assigned. 
   if ( _sql_statement ~ /^select / && _var_names != "" ) {_want_vars = "true"}

   # User wants variables assigned.
   if ( _want_vars == "true" ) {
      _sql_statement = "lines 0; " _sql_statement
      
      # Place all the users variables into an array.
      _var_array_sz = split(_var_names, _var_array, " ")
   }

   # Starting SQL.
   print _sql_statement | _pipe

   # Close files.
   close(_pipe_out)
   close(_pipe_err)

   # Assigning output to the output array.
   _nr = 0
   while ( ( getline < _pipe_out) > 0) {
      _nr++
      SqlOutput[_nr] = $0

      # If the user wants variables assigned, then when the first record is
      # returned we are done. 
      if (_want_vars == "true" && _nr == 9) { break }
   }

   # Assign the size of the array.
   SqlOutSz = _nr

   # Assigning errors to the error array.
   _nr = 0
   while ( (getline < _pipe_err) > 0 ) {
      _nr++
      SqlError[_nr] = $0
   }

   # Close files.
   close(_pipe_out)
   close(_pipe_err)

   system("> " _pipe_out)
   system("> " _pipe_err)

   # If variable assgnment is required, use the last record returned from
   # the SQL.
   if ( _want_vars == "true" ) {
      if (! is_empty(SqlError)) {
         # There was an error and no rows selected so assign blanks to all vars.
         for ( _count = 1; _count <= _sql_array_sz; _count++) {
            _array[_var_array[_count]] = ""
         }
      }
      else {
         # Rows were found so assign the first record to the vars.
         _sql_array_sz = split(SqlOutput[9], _sql_array, "|")

         for ( _count = 1; _count <= _sql_array_sz; _count++) {
            _array[_var_array[_count]] = truncate(_sql_array[_count])
         }
      }
   } 

   return SqlOutSz
}
# END OF FUNCTION SECTION.
# ------------------------


# PATTERN SECTION.
# ----------------
{
   sql("xlock tn_dets where transaction_type = 'ST';")
   if ( ! is_empty(SqlError) ) { print ">>ERROR locking tn_dets<<" }
   else { print ">>SUCCESS locking tn_dets<<" }
   for (Count = 1; Count <= SqlOutSz; Count++) { print SqlOutput[Count] }
   for (Item in SqlError) { print SqlError[Item] }

   sql("select transaction_no from tn_dets where transaction_type = 'ST';",
       "st_trans_no_ln", TnDets)
   if ( ! is_empty(SqlError) ) { print ">>ERROR selecting tn_dets<<" }
   else { print ">>SUCCESS selecting tn_dets<<" }
   for (Count = 1; Count <= SqlOutSz; Count++) { print SqlOutput[Count] }
   for (Item in SqlError) { print SqlError[Item] }

}
# END OF PATTERN SECTION.
# -----------------------


END {}
