##############################################################
#
# 03/02/2010  TW  Create SQL script to import data
#                 from PL_DATA_TO_LOAD.csv file
#
# Usage:
#
# awk -f PL_DATA_TO_LOAD.awk PL_DATA_TO_LOAD.txt > PL_DATA_TO_LOAD.sql
#
# PL_DATA_TO_LOAD.txt file - tab delimited (copy and paste from SQL Express results window into UltraEdit and saved)
#                          - all occurrences of ' replaced by ''
#
#############################################################

BEGIN {
	FS = "\t"
	print "set dateformat dmy"
	print ""
}

#"APPLICATION_NUMBER"|"CASE_OFFICER_NAME"|"DATE_DECISION"|"DATE_OF_APPEAL_DECISION"|"APPEAL_DECISION_DESCRIPTION"|"APPLICATION_TYPE_DESCRIPTION"|"DECISION_DESCRIPTION"|"SITE_ADDRESS"|"PROPOSAL"|"STATUS_DESCRIPTION"|"DATE_REGISTERED"|"PK"
	NR == 1 { next }

{
	print "insert into mv_pl_data (application_number,case_officer_name,date_decision,date_of_appeal_decision,appeal_decision_description,application_type_description,decision_description,site_address,proposal,status_description,date_registered,pk)"
	
	row = "   values ("
	for (i = 1; i <= 12; i++){
		if ( i ==  1 ) row = row "'"$1"',"
		if ( i ==  2 ) row = row "'"$2"',"
		if ( i ==  3 && $3 == "" ) row = row "null,"
		if ( i ==  3 && $3 != "" ) row = row "CAST(\'"$3"\' AS DATETIME),"
		if ( i ==  4 && $4 == "" ) row = row "null,"
		if ( i ==  4 && $4 != "" ) row = row "CAST(\'"$4"\' AS DATETIME),"
		if ( i ==  5 ) row = row "'"$5"',"
		if ( i ==  6 ) row = row "'"$6"',"
		if ( i ==  7 ) row = row "'"$7"',"
		if ( i ==  8 ) row = row "'"$8"',"
		if ( i ==  9 ) row = row "'"$9"',"
		if ( i == 10 ) row = row "'"$10"',"
		if ( i == 11 && $11 == "" ) row = row "null,"
		if ( i == 11 && $11 != "" ) row = row "CAST(\'"$11"\' AS DATETIME),"
		if ( i == 12 ) row = row "'"$12"')"
	}
	print row
}

END {
	print ""
	print "go"
}