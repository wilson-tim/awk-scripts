###############################################################################
#                                                                             #
# unify_informix script VERSION 1a                                            #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 23/11/2001                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#  awk -f unify_informix <unify sql schema>                                   #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
# This script will take a unify schema and turn it into the equivalent        #
# informix schema.                                                            #
#                                                                             #
###############################################################################

BEGIN {
   Table = "false"; Index = "false"; PrevLine = ""
   config = "false"; Base = "false"; BaseValue = 0
}


# FUNCTION SECTION.
# -----------------
function unify_to_informix () {
   gsub(/[ \t]huge/,"\t",PrevLine)
   gsub(/[ \t]time/,"\tdatetime hour to minute",PrevLine)
   gsub(/[ \t]binary/,"\tbyte",PrevLine)
   gsub(/[ \t]amount/,"\tmoney",PrevLine)
   if (Base == "true") {
      gsub(/[ \t]numeric.\(.*\)/,"\tserial (" BaseValue ")",PrevLine)
   }
   else {
      gsub(/[ \t]numeric.\(.*\)/,"\tinteger",PrevLine)
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

# This function deletes all elements from an array.
function darray( _array,   # Arguments
   _item ) {   # Local variables

   if ( ! is_empty(_array) ) {
      for (_item in _array) { delete _array[_item] }
   }
}
# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------
# SQL COMMENTS SECTION
# Keep all sql comments
$1 ~ /^--/ {
   print $0
}

# TABLE SECTION
# Table name and start of a table description.
$1 == "create" && $2 == "table" {
   print ""
   Table = "true"
   gsub(/"/,"",$0)
   PrevLine = $0
   darray(KeyArray)
   next
}

# Primary key declaration.
$1 == "primary" && Table == "true" {
   gsub(/"/,"",$0)
   print PrevLine
   PrevLine = $0
   next
}

# Field name.
$1 ~ /".*"/ && Table == "true" {
   gsub(/"/,"",$0)
   if ($0 ~ /not null/) {
      KeyArray[$1] = "KEY"
   }
   unify_to_informix()
   print PrevLine
   PrevLine = $0
   Config = "false"
   Base = "false"
   BaseValue = 0
   next
}

# Field configuration.
$1 == "configuration" && Table == "true" {
   config = "true"
   if (PrevLine !~ /create table/) {
      PrevLine = PrevLine ","
   }
   next
}

# Direct base check.
/direct base/ && Table == "true" && config == "true" {
   gsub(/,/,"",$3)
   Base = "true"
   BaseValue = $3
} 

# End of table description.
/commit work;/ && Table == "true" {
   unify_to_informix()
   gsub(/,/,"",PrevLine)
   gsub(/"/,"",PrevLine)
   if (PrevLine !~ /\);/) {
      print PrevLine ");"
   }
   else {
      print PrevLine
   }
   print $0
   Table = "false"
   PrevLine = ""
   next
}

# INDEX SECTION
# Index name and start of an index description.
/create .* index/ {
   Index = "true"
   gsub(/btree index/,"index",$0)
   gsub(/hash index/,"index",$0)
   gsub(/"/,"",$0)
   if (match($0,/\(.*[^,].*\)/)) {
      if (substr($0,RSTART,RLENGTH) in KeyArray) {
         gsub(/\)/," DESC)", $0)
      }
   }
   PrevLine = $0
   next
}

# Field name
$1 ~ /".*"/ && Index == "true" {
   gsub(/"/,"",$0)
   print PrevLine
   PrevLine = $0
   next
}

/commit work;/ && Index == "true" {
   Index = "false"
   print PrevLine ";"
   print $0
   PrevLine = ""
   next
}
# -----------------------
# END OF PATTERN SECTION.


END {}
