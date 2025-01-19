###############################################################################
#                                                                             #
# Blank script VERSION 0.01                                                   #
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
   Cmd1 = "SQL -q 2>&1"
   Sql1 = "xlock tn_dets where transaction_type = 'ST';"
   Sql2 = "select transaction_no from tn_dets where transaction_type = 'ST';"
   Cmd2 = " SQL 2>&1"

   print Sql1 | Cmd1
   print Sql2 | Cmd2
}


# FUNCTION SECTION.
# -----------------

# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------
{ exit }  
# -----------------------
# END OF PATTERN SECTION.


END {
   close(Cmd)
   close(Cmd)
}
