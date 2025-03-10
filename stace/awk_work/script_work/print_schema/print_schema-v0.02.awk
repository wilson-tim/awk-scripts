#! /usr/bin/awk -f

###############################################################################
#                                                                             #
# print_schema script VERSION 0.02                                            #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 10/05/2001                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#     print_schema SchemaFile                                                 #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
# This program creates a printable schema which it sends to standard out. The #
# format it sends out for each table is as follows;                           #
#                                                                             #
# *table_name - 'description of table'*                                       #
# field_name<TAB>type KEY                                                     #
#             .                                                               #
#             .                                                               #
#             .                                                               #
# field_name<TAB>type                                                         #
#             .                                                               #
#             .                                                               #
#             .                                                               #
# <RETURN>                                                                    #
#                                                                             #
# The stars around the header (table name and description) can be used to     #
# denote bold.                                                                #
#                                                                             #
#                                                                             #
###############################################################################

BEGIN {
   Header = ""; Table = "false"
}

# BEGIN FUNCTIONS
# ---------------
# Takes the field number to clean.
function clean(_field) {
   gsub(/"/,"",$_field)
   gsub(/,/,"",$_field)
   gsub(/;/,"",$_field)
   gsub(/')/,"'",$_field)
   gsub(/))/,")",$_field)
}

# Retrieves the description from the description line.
function description(   _count, _description) {
   for(_count = 2; _count <= NF; _count++) {
      if(_count == NF) {
         clean(_count)
         _description = _description $_count
      }
      else {
         _description = _description $_count " "
      }
   }
   return _description
}
# -------------
# END FUNCTIONS

# BEGIN PATTERNS
# --------------
# Table name and start of a table description.
$1 == "create" && $2 == "table" {
   Table = "true"
   clean(3)
   Header = "*" $3 " - "
   next
}

# Retrieve descrition and place it after the table name.
/'.*'/ && $1 == "description"  && Table == "true" {
   print Header description() "*"
   Header = ""
   next
}

# Field and field type plus primary key identifier if required.
$1 ~ /".*"/ && Table == "true" {
   clean(1); clean(2); clean(3)
   if ($0 ~ /not null/) { print $1 "\t" $2, $3, "KEY" > "key.tmp" }
   else { print $1 "\t" $2, $3 > "notkey.tmp" }
   next
} 

# End of table description, so skip rest of the lines until another table
# description comes along.
/commit work;/ && Table == "true" {
   # Close the temp files which are being written too.
   close("key.tmp")
   close("notkey.tmp")

   # Sort and print the temp files.
   while ( ("sort key.tmp" | getline) > 0) { print }
   close("sort key.tmp")
   while ( ("sort notkey.tmp" | getline) > 0) { print }
   close("sort notkey.tmp")

   # Close the temp files which are being read.
   close("key.tmp")
   close("notkey.tmp")

   Header = ""; Table = "false"
   print ""
}
# ------------
# END PATTERNS

END {
   # Remove the temporary files.
   system("rm key.tmp")
   system("rm notkey.tmp")
}
