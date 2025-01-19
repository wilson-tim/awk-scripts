#! /usr/bin/awk -f

###############################################################################
#                                                                             #
# ass_and_pr.awk script VERSION 0.01                                          #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 31/05/2001                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#  nhs_sup                                                                    #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
# The script takes an ascii comma seperated file from $DBPATH/raw_data called #
# ????ass.csv, and loads the data into the $DBPATH database, in the tables    #
# oh_dets and ol_dets. The program creates a temporay file                    #
# $PHABASE/tmp/ass_and_pr.tmp which is removed when the load is complete. The #
# $DBPATH/raw_data/????ass.csv file is also deleted on a successful load.     #
# This script also checks the order numbers it is loading to make sure that   #
# they have not been used before.
# This script is run from within the ass_and_pr.fs pharaoh script and will    #
# live in the $BINDIR directory.                                              #
#                                                                             #
###############################################################################

BEGIN {
   # Comma seperated file.
   FS = ","

   # Set up the command to get a list of all the files to be transfered.
   Cmd = "ls -1 " ENVIRON["DBPATH"]\
         "/raw_data/[0-9][0-9][0-9][0-9]ass.csv 2>/dev/null"

   # Test to see if files exist for transferring.
   Cmd | getline FilesToTransfer
   if (FilesToTransfer == "") {
      print ">>There are no files to import."
   }       
   close(Cmd)
 
   # Get each order number file in turn. 
   # -- START FILE LOOP --
   while ((Cmd | getline) > 0) {
 
      # Set the Section counter to zero.
      DoneSection = "false"

      # Set the order number input file.
      AssAsc = $1

      NoRows = 0
      NoUpds = 0
   
      # Update the oh_dets and ol_dets tables with the order numbers
      # -- START LOOP THROUGH CURRENT FILE --
      while ((getline < AssAsc) > 0 ) {
         # Count The number of records in the file.
         NoRows++
         
         # Update flag
         UpdateOk = "true"

         # Comma seperated file, so strip off quotes.
         gsub("\"","",$0)

         # Remember the requisition and order numbers 
         ReqNum = $1
         OrdNum = $2

         # -- Check that the order number has not been used before.
         sql("select count(*) from oh_dets where order_number = " OrdNum ";")

         if (SqlOutput[SqlOutSz - 2] != 0) {
            UpdateOk = "false"
            print ">>Error importing from " AssAsc
            print ">>order number: " OrdNum " already in-use"
            print ">>unable to assign to requisition number: " ReqNum
         } 
         # -- Check that the order number has not been used before.
       
         # -- Do the oh_dets update
         if (UpdateOk == "true") {
            sql("update oh_dets set order_number = " OrdNum \
                " where purchase_req_no = " ReqNum \
                " and order_status = 'A';")

            if (SqlOutput[SqlOutSz - 2] != "1 row(s) updated.") {
               UpdateOk = "false"
               print ">>Error importing from " AssAsc
               print ">>updateing oh_dets for;"
               print ">>order number: " OrdNum \
                     " and requisition number: " ReqNum 
            }
         }
         # -- Do the oh_dets update

         # -- Do the ol_dets updates
         if (UpdateOk == "true") {
            sql("update ol_dets set order_number = " OrdNum \
                " where purchase_req_no = " ReqNum ";")

            if (head(SqlOutput[SqlOutSz - 2]) > 0) {
               # Update was successfull
               NoUpds++
            }
            else {
               UpdateOk = "false"
               print ">>Error importing from " AssAsc
               print ">>updateing ol_dets for;"
               print ">>order number: " OrdNum \
                     " and requisition number: " ReqNum 
            }
         }
         # -- Do the ol_dets updates

      }
      # -- END LOOP THROUGH CURRENT FILE --
   
      if (NoRows == NoUpds) { DoneSection = "true" }
 
      close(AssAsc)

      # Remove the files
      if (DoneSection == "true") {
         print ">>" AssAsc " successfully imported."
         print ""
         system("rm " AssAsc)
      }

   }
   # -- END FILE LOOP --
   
   exit
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

# This function returns the substring from the start of the string to the first
# occurence of a space.
function head( _string ) {   # Arguments
   return substr(_string, 1, (index(_string, " ") - 1 ) )
}
# ------------------------
# END OF FUNCTION SECTION.

END {
   close(Cmd)
   print ""
   print "PRESS ANY KEY TO CONTINUE ..."
   getline
}
