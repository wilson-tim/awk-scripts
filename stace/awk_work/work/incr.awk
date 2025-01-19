###############################################################################
#                                                                             #
# incr.awk script VERSION 1a                                                  #
# (c) William Wragg/Datapro Software Ltd. 2002                                #
# BY WILLIAM WRAGG                                                            #
# DATE 23/01/2002                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with: awk -f incr.awk <ascii ph_hist file>                            #
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
   Incr = 580797
   for (i=1; i<=10000; i++) {
      Incr++
      print Incr " | |7001 |1 |SXH|MNB| | | | 0.00| 0|HSP | | | | | | |test |000000|000001|000|Building External Fabric|MAIN| 0.00| 0.00|BUILD1| | | | | **********| **********| 29/08/2001| 0.00| 0.00| 11.00| | 0|ESMN|2000| 2| | |8| 0.00| 535842| 474836| 181818| 181818| 181818| 181819| 181818| 0.00| 0.00| 0.00| | | | **********|00:00| **********|00:00| **********|00:00| 0.00| 0.00|00:00| 0.00| 0.00| | **********|00:00| | | |N|00:00"
   }
}
