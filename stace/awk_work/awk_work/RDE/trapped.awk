###############################################################################
#                                                                             #
# Trapped Commitment VERSION 0.01                                             #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 28/06/2001                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#     awk -f trapped.awk                                                      #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
###############################################################################

BEGIN {
   # Find all the order headers with status of 'I'.
   sql("lines 0; select order_number from oh_dets where order_status = 'I';")
   
   if (SqlOutput[SqlOutSz - 2] == "There were no rows selected.") {
      print SqlOutput[SqlOutSz - 2]
   }
   else {
      # Save the output from the order header sql.
      for (Item in SqlOutput) { OrdSqlOutput[Item] = SqlOutput[Item] }
      OrdSqlOutSz = SqlOutSz

      OrdCnt = 0

      # Loop through each of the order headers found. 
      for (Count = 9; Count <= OrdSqlOutSz - 2; Count++) {
         # Select ALL the order lines for the order header.
         sql("lines 0; select count(*) from ol_dets where order_number = " \
             OrdSqlOutput[Count] ";")
         AllLinesCnt = truncate(SqlOutput[SqlOutSz - 2])

         # Just select the 'C' and 'X' order lines.
         sql("lines 0; select count(*) from ol_dets where order_number = " \
             OrdSqlOutput[Count] "and line_status in ('C','X');")
         CXLinesCnt = truncate(SqlOutput[SqlOutSz - 2])

         if (AllLinesCnt == CXLinesCnt) { 
            print OrdSqlOutput[Count]
            OrdCnt++
         }
      }
      print OrdCnt " row(s) selected."
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


# PATTERN SECTION.
# ----------------

# -----------------------
# END OF PATTERN SECTION.


END {}
