#! /usr/bin/awk -f

###############################################################################
#                                                                             #
# nhs_sup.awk script VERSION 0.07                                             #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 26/02/2001                                                             #
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
# nhs_sup.asc, and loads the data into the $DBPATH database, in the table     #
# nhs_sup. The program creates a temporay file $PHABASE/tmp/nhs_sup.tmp which #
# is removed when the load is complete. The $DBPATH/raw_data/nhs_sup.asc file #
# is also deleted on a successful load.                                       #
# The script also retrieves the nhs transaction number from tn_dets, and      #
# updates it on a successful load of the ascii data into the nhs_sup table.   #
# This script is run from within the nhs_sc_iss.fs pharaoh script and will    #
# live in the $BINDIR directory.                                              #
#                                                                             #
###############################################################################

BEGIN {
   # Comma seperated file.
   FS = ","

   # Set up the command to get a list of all the files to be transfered.
   Cmd = "ls -1 " ENVIRON["DBPATH"]\
         "/raw_data/[0-9][0-9][0-9][0-9]nhs.csv 2>/dev/null"

   # Test to see if files exist for transferring.
   Cmd | getline FilesToTransfer
   if (FilesToTransfer == "") {
      print ">>There are no files to import."
   }       
 
   # Get each NHS Supplies file in turn. 
   # -- START FILE LOOP --
   while ((Cmd | getline) > 0) {
 
      # Set the Section counter to zero.
      DoneSection = 0

      # Set the temporary file and the NHS Supplies input file.
      NhsTemp = ENVIRON["PHABASE"] "/tmp/nhs_sup.tmp"
      NhsAsc = $1

      # -- SECTION 1 --
      # Check to see if the batch_id has beem transferred before.
      getline < NhsAsc
      sql("lines 0; select count(*) from nhs_sup where batch_id = " $1 ";")
      close(NhsAsc)

      if (truncate(SqlOutput[SqlOutSz - 2]) != 0 ) { 
         system("rm " NhsAsc)
         print ">>Error importing from " NhsAsc
         print ">>batch date already processed."
 
         # Get next file to process.
         continue
      }
      else {
         # Get the tn_dets number.
         sql("lines 0; select transaction_no from tn_dets where transaction_type = 'NS';")

         if (SqlOutput[SqlOutSz - 2] != "There were no rows selected.") {
            DoneSection = 1
         }
         else {
            print ">>Error importing from " NhsAsc
            print ">>selecting from tn_dets" 
         }
      }
      # -- END SECTION 1 --
   
      # -- SECTION 2 --
      if (DoneSection == 1) {
         # Get the Last transaction value.
         NhsTran = truncate(SqlOutput[SqlOutSz - 2])
   
         NoRows = 0
   
         # Create the ascii text file ready to be loaded into nhs_sup
         while ((getline < NhsAsc) > 0 ) {
            # Increment transaction number.
            NhsTran++
   
            # Count The number of records in the file.
            NoRows++
   
            # Comma seperated file, so strip off quotes.
            gsub("\"","",$0)
   
            Record = NhsTran "|" $1 "|" $2 "|" $3 "|" $4\
                             "|" $5 "|" $6 "|" $7 "|" "N"
            print Record > NhsTemp
         }
   
         if (NoRows > 0) { DoneSection = 2 }
      }
      # -- END SECTION 2 --
   
      if (DoneSection > 0 ) {
         close(NhsTemp)
         close(NhsAsc)
      }
   
      # -- SECTION 3 --
      if (DoneSection == 2) {
         # Do the insert into the nhs_sup table.
         sql("insert into nhs_sup values from '" NhsTemp "';")
   
         if (SqlOutput[SqlOutSz - 2] == NoRows " row(s) added.") {
            DoneSection=3
         }
         else {
            print ">>Error importing from " NhsAsc
            print ">>inserting into nhs_sup" 
         }
      }
      # -- END SECTION 3 --
   
      # -- SECTION 4 --
      if (DoneSection == 3) {
         # Do the tn_dets update.
         sql("update tn_dets set transaction_no = " NhsTran\
             " where transaction_type = 'NS';")
   
         if (SqlOutput[SqlOutSz - 2] == "1 row(s) updated.") {
            DoneSection = 4
         }
         else {
            print ">>Error importing from " NhsAsc
            print ">>updateing tn_dets with value " NhsTran
         }
      }
      # -- END SECTION 4 --
   
      # Remove the files
      if (DoneSection >= 2) { system("rm " NhsTemp) }
      if (DoneSection == 4) { system("rm " NhsAsc) }

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
# ------------------------
# END OF FUNCTION SECTION.

END {
   print
   print "PRESS ANY KEY TO CONTINUE ..."
   getline
}
