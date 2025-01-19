BEGIN {
   header = ""; table = "false"; key = ""
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
   table = "true"
   clean(3)
   header = "*" $3 " - "
   next
}

# Retrieve descrition and place it after the table name.
/'.*'/ && $1 == "description"  && table == "true" {
   print header description() "*"
   header = ""
   next
}

# This field is a primary key field.
/not null/ && table == "true" {
   key = "KEY"
}

# Field and field type plus primary key identifier if required.
$1 ~ /".*"/ && table == "true" {
   clean(1); clean(2); clean(3)
   print $1 "\t" $2, $3, key
   key = ""
   next
} 

# End of table description, so skip rest of the lines until another table
# description comes along.
/commit work;/ && table == "true" {
   header = ""; table = "false"; key = ""
   print "\r"
}
# ------------
# END PATTERNS
