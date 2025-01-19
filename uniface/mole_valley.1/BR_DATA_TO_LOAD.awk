##############################################################
#
# 04/02/2010  TW  Create SQL script to import data
#                 from BR_DATA_TO_LOAD.csv file
#
# Usage:
#
# awk -f BR_DATA_TO_LOAD.awk BR_DATA_TO_LOAD.txt > BR_DATA_TO_LOAD.sql
#
# BR_DATA_TO_LOAD.txt file - tab delimited (copy and paste from SQL Express results window into UltraEdit and saved)
#                          - all occurrences of ' replaced by ''
#
#############################################################

BEGIN {
	FS = "\t"
	print "set dateformat dmy"
	print ""
}

#"APPLIC_NUMBER"|"APPLIC_TYPE"|"CASE_OFF"|"COMMENCED"|"COMPLETED"|"DECISION"|"PROPOSAL"|"SITE"|"STATUS"|"DECIDED"
	NR == 1 { next }

{
	print "insert into mv_br_data (applic_number,applic_type,case_off,commenced,completed,decision,proposal,site,status,decided)"
	
	row = "   values ("
	for (i = 1; i <= 10; i++){
		if ( i ==  1 ) row = row "'"$1"',"
		if ( i ==  2 ) row = row "'"$2"',"
		if ( i ==  3 ) row = row "'"$3"',"
		if ( i ==  4 && $4 == "" ) row = row "null,"
		if ( i ==  4 && $4 != "" ) row = row "CAST(\'"$4"\' AS DATETIME),"
		if ( i ==  5 && $5 == "" ) row = row "null,"
		if ( i ==  5 && $5 != "" ) row = row "CAST(\'"$5"\' AS DATETIME),"
		if ( i ==  6 ) row = row "'"$6"',"
		if ( i ==  7 ) row = row "'"$7"',"
		if ( i ==  8 ) row = row "'"$8"',"
		if ( i ==  9 ) row = row "'"$9"',"
		if ( i == 10 && $10 == "" ) row = row "null )"
		if ( i == 10 && $10 != "" ) row = row "CAST(\'"$10"\' AS DATETIME) )"
	}
	print row
}

END {
	print ""
	print "go"
}