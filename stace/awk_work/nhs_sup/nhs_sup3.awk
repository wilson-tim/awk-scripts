#! /usr/bin/awk -f

###############################################################################
#                                                                             #
# nhs_sup.awk script VERSION 0.03                                             #
# (c) William Wragg/Datapro Software Ltd. 2000                                #
# BY WILLIAM WRAGG                                                            #
# DATE 02/10/2000                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#                                                                             #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
###############################################################################

BEGIN {
   FS = "|"
   SelectSuccess = "true"

   sql("lines 0; select transaction_no from tn_dets where transaction_type = 'NS';")

   if (SqlOutput[SqlOutSz - 2] != "There were no rows selected.") {
      # Get the Last transaction value.
      NhsTran = truncate(SqlOutput[SqlOutSz - 2])

      # Set the temporary file and the NHS Supplies input file.
      NhsTemp = ENVIRON["PHABASE"] "/tmp/nhs_sup.tmp"
      NhsAsc = ENVIRON["DBPATH"] "/raw_data/nhs_sup.asc"

      NoRows = 0

      # Create the ascii text file reday to be loaded into nhs_sup
      while ((getline < NhsAsc) > 0 ) {
         # Increment transaction number.
         NhsTran++
         NoRows++
         Record = NhsTran "|" $1 "|" $2 "|" $3 "|" $4\
                          "|" $5 "|" $6 "|" $7 "|" "N"
         print Record > NhsTemp
      }
   }
   else { 
      print ">>Error selecting from tn_dets<<"
      SelectSuccess = "false"
   }
}


# FUNCTION SECTION.
# -----------------
function sql( _sql_statement,   # Arguments
   _nr, _cmd ) {   # Local variables

   carray(SqlOutput)
   SqlOutSz = 0
   _nr = 0
   _cmd = "echo \"" _sql_statement "\" | SQL 2>&1"

   # Starting SQL.
   while ( (_cmd | getline) > 0) {
      _nr++
      SqlOutput[_nr] = $0
   }

   SqlOutSz = _nr
   close(_cmd)
}

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
# ------------------------
# END OF FUNCTION SECTION.
{ exit }
# PATTERN SECTION.
# ----------------

# -----------------------
# END OF PATTERN SECTION.


END {
   
   if (SelectSuccess == "true") { 
      close(NhsTemp)
      close(NhsAsc)
      InsertSuccess = "true"
   }
   else { InsertSuccess = "false" }

   InsertTest = NoRows " row(s) added."

   if (SelectSuccess == "true") {
      # Do the insert into the nhs_sup table.
      sql("insert into nhs_sup values from '" NhsTemp "';")

      if (SqlOutput[SqlOutSz - 2] != InsertTest) { 
         print ">>Error inserting into nhs_sup<<"
         InsertSuccess = "false"
      }
   }

   if (InsertSuccess == "true") {
      # Do the tn_dets update.
      sql("update tn_dets set transaction_no = " NhsTran\
          " where transaction_type = 'NS';")

      if (SqlOutput[SqlOutSz - 2] != "1 row(s) updated.") {
         print ">>Error updateing tn_dets with value " NhsTran "<<"
         InsertSuccess = "false"
      } 
   }

   # Remove the files
   if (SelectSuccess == "true") { system("rm " NhsTemp) }
   if (InsertSuccess == "true") { system("rm " NhsAsc) } 
}
