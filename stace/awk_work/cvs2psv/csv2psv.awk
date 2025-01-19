###############################################################################
#                                                                             #
# csv2psv.awk script VERSION 0.03                                             #
# (c) William Wragg/Datapro Software Ltd. 2003                                #
# BY WILLIAM WRAGG                                                            #
# DATE 20/11/2003                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#  awk -f csv2psv.awk <csv file> > <psv file>                                 #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
#                                                                             #
# Local variables are declared as extra parameters in the parameter list of   #
# function definitions. The convention is to separate local variables from    #
# real parameters by extra spaces in the parameter list. But I use an         #
# underscore in front of the names of all local variables.                    #
#                                                                             #
###############################################################################

BEGIN {
  FS = ","
  OFS = "|"
}

# FUNCTION SECTION.
# -----------------
function print_field (field, sep) {
  gsub(/\"/,"",field)
  printf field sep
}
# ------------------------
# END OF FUNCTION SECTION.

# PATTERN SECTION.
# ----------------
{
  # loop through each of the fields
  quotes = "false"
  for (i=1; i<NF; i++) {
    # if the field starts with a "(quote) then need to put back the commas
    # until the matching quote is found. All other fields print with a pipe(|)
    # after them.
    gsub(/\%/,"%%", $i)
    if ($i ~ /.*"$/) {
      # ending quotes
      quotes = "false"
      print_field($i,"|")
    } else if ($i ~ /^".*/) {
      # begining quotes
      quotes = "true"
      print_field($i,",")
    } else if (quotes == "true") {
      # within quotes
      print_field($i,",")
    } else {
      # no quotes
      print_field($i,"|")
    }
  }
  
  # print the last field with a pipe.
  gsub(/\"/,"",$i)
  print $NF "|"
}
# -----------------------
# END OF PATTERN SECTION.

END {}
