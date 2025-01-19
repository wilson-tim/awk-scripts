###############################################################################
#                                                                             #
# rcount.awk script VERSION 0.01                                              #
# (c) William Wragg/Datapro Software Ltd. 2001                                #
# BY WILLIAM WRAGG                                                            #
# DATE 27/02/2001                                                             #
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

BEGIN { rcount = 0 }


# FUNCTION SECTION.
# -----------------

# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------
{
   if ($0 !~ /\\$/) { rcount++ }
}
# -----------------------
# END OF PATTERN SECTION.


END { print rcount }
