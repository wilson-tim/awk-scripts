###############################################################################
#                                                                             #
# nested.awk script VERSION 1a                                                #
# (c) William Wragg/Datapro Software Ltd. 2002                                #
# BY WILLIAM WRAGG                                                            #
# DATE 21/01/2002                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with: awk -f nested.awk <ACCELL/SQL script .fs file>                  #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
###############################################################################

BEGIN {
   Np = 0
}


# FUNCTION SECTION.
# -----------------
# pprint - pretty_print - prints;
# <line number> <(3(Np-1) spaces> <String> (<Np>)
function pprint(_string) {
   printf("%s\t", NR)
   rprint()
   printf("%s ", _string)
   printf("(%s)\n", Np)
}

# printf 3 x (Np-1) spaces with nonewline
function rprint(){
   for (i=Np; i>1; i--) {
      printf("|   ")
   }
}
# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------
tolower($1) == "begin" {
   Np++
   pprint("begin")
}

tolower($1) == "end" {
   pprint("end")
   Np--
}
# -----------------------
# END OF PATTERN SECTION.


END {}
