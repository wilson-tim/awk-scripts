##############################################################
#
# 17/11/2009  TW  Create SQL script to import data
#                 from CR_DECISION_DATES.csv file
#
# Usage:
#
# awk -f CR_DECISION_DATES.awk CR_DECISION_DATES.csv > CR_DECISION_DATES.sql
#
#############################################################

BEGIN {FS = "\,"}
NR == 1 { next }
$2=="" {print "insert into cr_decision_dates (application_number, decision_date) values (\'"$1"\', null)" }
$2!="" {print "insert into cr_decision_dates (application_number, decision_date) values (\'"$1"\', CAST(\'"$2"\' AS DATETIME))" }
END { print "go" }