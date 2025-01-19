##############################################################
#
# 01/03/2010  TW  Quick AWK for Redbridge data
#
# Usage:
#
# awk -f quickawk1.awk PLANES_MATCHED_TO_LLPG_UPRN_ONLY.txt > QUICKAWK1.txt
#
# PLANES_MATCHED_TO_LLPG_UPRN_ONLY.txt file - | delimited
#
#############################################################




BEGIN {
  FS = "|"
  OFS = "|"
}

NF != 10 {
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


