##############################################################
#
# 07/06/2010  TW  Quick AWK for Redbridge data
#
# Usage:
#
# gawk -f quickawk1.awk CopytblPLANES_MATCHED_WITH_CODES_AND_DESCRIPTIONS.txt > QUICKAWK1.txt
#
# CopytblPLANES_MATCHED_WITH_CODES_AND_DESCRIPTIONS.txt file - , delimited
#
#############################################################




BEGIN {
  FS = "|"
  OFS = "|"
}

NF != 38 {
  print NR " *** " NF " *** " $0
  next
}



END {}


