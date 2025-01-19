##############################################################
#
# 24/02/2010  TW  Correct source data file
#
# Usage:
#
# awk -f edit2.awk MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt > MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_EDIT2.txt
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

# Process complete data row (previous incomplete data row processing completed)
NF == 20  && part_line == "false" {
  part_line = "false"
  gsub(/\r/, " ", $0)
  print $0
  next
}

# Process complete data row (previous incomplete data row processing not yet completed)
NF == 20  && part_line == "true" {
  # Finish processing incomplete data row
  print ""
  # Now process complete data row
  part_line = "false"
  gsub(/\r/, " ", $0)
  print $0
  next
}

# Process first incomplete data row
NF < 20 && part_line == "false" {
  part_line = "true"
  gsub(/\r/, " ", $0)
  printf $0
  next
}

# Process subsequent incomplete data row
NF < 20 && part_line == "true" {
  gsub(/\r/, " ", $0)
  printf " " $0
  next
}

END {}


