##############################################################
#
# 23/02/2010  TW  Correct source data file
#
# Usage:
#
# awk -f quickawk.awk MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt > MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_QUICKAWK3.txt
#
# MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt file - | delimited
#                                                    - all occurrences of ENTER character in field 7 replaced by ''
#
#############################################################




BEGIN {
  FS = "|"
  OFS = "|"
}

NF != 20 {
  print NR " *** " NF " *** " $0
  next
}

#NF > 20 {
#  print NR " *** " NF " *** " $0
#  next
#}

#length($7) > 250 {
#	print length($7) " *** " $0
#}




END {}


