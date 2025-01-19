###############################################################################
#                                                                             #
# lambda script VERSION 1a                                                    #
# (c) William Wragg/Datapro Software Ltd. 2000                                #
# BY WILLIAM WRAGG                                                            #
# DATE 02/10/2000                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#    awk -f lambda_1a.awk -f lambda-test-1a.awk                               #
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
  x = 9
  y = 10
  print lambda("x, y", "return x + y" , "2 , 34")
  print lambda("x", "return (x<2? 1: x * _(--x))", 100)
}


# FUNCTION SECTION.
# -----------------


# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------

# -----------------------
# END OF PATTERN SECTION.


#END {}
