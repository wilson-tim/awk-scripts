##############################################################
#
# 23/02/2010  TW  Correct source data file
#
# Usage:
#
# awk -f edit1.awk MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt > MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_TEST3.txt
#
# MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt file - | delimited
#                                                    - all occurrences of new lines (0D0A, 0D and 0A) in fields 6 and 7 are corrected by AWK below
#
#############################################################




BEGIN {
  FS = "|"
  OFS = "|"
  part_line = "false"
}

NF == 20  && part_line == "false" {
  part_line = "false"
  gsub(/\r/, " ", $0)
  gsub(/\n/, " ", $0)
  print $0
  next
}

NF < 20 && part_line == "false" {
  part_line = "true"
  gsub(/\r/, " ", $0)
  gsub(/\n/, " ", $0)
  printf $0
  next
}

#NF < 20 && part_line == "true" {
NF > 1 && NF < 20 && part_line == "true" {
  part_line = "false"
  gsub(/\r/, " ", $0)
  gsub(/\n/, " ", $0)
  print " " $0
  next
}

#NF == 1 {
NF <= 1 && part_line == "true" {
  gsub(/\r/, " ", $0)
  gsub(/\n/, " ", $0)
  printf " " $0
  next
}



END {}


