##############################################################
#
# 25/02/2010  TW  Create SQL script to import data
#                 from MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_TEST2.txt file
                  into table MV_PL_DATA_2 (avoiding DTS import truncation problem)
#
# Usage:
#
# awk -f PL_DATA_TO_LOAD.awk MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_TEST2.txt > mv_pl_data_2.sql
#
# MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_TEST2.txt file - tab delimited
#
#############################################################

BEGIN {
	FS = "|"
	outputfilename = "TEST"
	outputfileext = ".SQL"
	oldoutputfile = ""
}

	NR == 1 { next }
	
	# Process 10000 data rows per output file
	outputfileno = NR - ( (NR - 1) % 10000 )
	outputfile = outputfilename outputfileno outputfileext
	
	oldoutputfile == "" {
		oldoutputfile = outputfile
		# Start new output file
		now = systime()
		print "-- " outputfile " created " strftime("%d/%m/%Y %H:%M:%S", now) > outputfile
		print "" >> outputfile
		print "use p_8301_dev_data" >> outputfile
		print "" >> outputfile
		print "set dateformat dmy" >> outputfile
		print "" >> outputfile
	}
	
	oldoutputfile != outputfile {
		# Complete old output file
		print ""  >> oldoutputfile
		print "go" >> oldoutputfile
		
		# Start new output file
		oldoutputfile = outputfile
		print "-- " outputfile " created " strftime("%d/%m/%Y %H:%M:%S", now) > outputfile
		print "" >> outputfile
		print "" >> outputfile
		print "use p_8301_dev_data" >> outputfile
		print "" >> outputfile
		print "set dateformat dmy" >> outputfile
		print "" >> outputfile
	}
{
	print "insert into mv_pl_data_2 (nis_pkreference,planappref_duplicatecount,nis_planappref,apas_planappref,nis_planapptype,nis_planappaddress,nis_planappproposal,nis_planappdecisiondate,nis_planappdecisioncode,nis_planappdecisiondesc,nis_planappreceiveddate,nis_planappcreatedate,apas_applicationtypedesc,apas_decisiondesc,nis_appeal,nis_appealcode,nis_appealtype,nis_appealdecisiontype,nis_appealdecisiontext,nis_appealdecisiondate)" >> outputfile
	
	row = "   values ("
	for (i = 1; i <= 20; i++){
		# Remove initial and final double quotes if present
		if (($i ~ /^".*/) && ($i ~ /.*"$/)) {
			$i = substr($i, 2, (length($i) - 2))
			# Replace single quote with double single quote
			data = ""
			for (j = 1; j <= length($i); j++) {
				if (substr($i, j, 1) == "'") data = data "''"
				if (substr($i, j, 1) != "'") data = data substr($i, j, 1)
			}
			# Replace double double quotes with single double quotes
			gsub(/\"\"/, "\"", data)
			$i = data
		}
		
		if ( i ==  1 ) row = row "'"$1"',"
		if ( i ==  2 ) row = row "'"$2"',"
		if ( i ==  3 ) row = row "'"$3"',"
		if ( i ==  4 ) row = row "'"$4"',"
		if ( i ==  5 ) row = row "'"$5"',"
		if ( i ==  6 ) row = row "'"$6"',"
		if ( i ==  7 ) row = row "'"$7"',"
		if ( i ==  8 && $8 == "" ) row = row "null,"
		if ( i ==  8 && $8 != "" ) row = row "CAST(\'"$8"\' AS DATETIME),"
		if ( i ==  9 ) row = row "'"$9"',"
		if ( i == 10 ) row = row "'"$10"',"
		if ( i == 11 && $11 == "" ) row = row "null,"
		if ( i == 11 && $11 != "" ) row = row "CAST(\'"$11"\' AS DATETIME),"
		if ( i == 12 && $12 == "" ) row = row "null,"
		if ( i == 12 && $12 != "" ) row = row "CAST(\'"$12"\' AS DATETIME),"
		if ( i == 13 ) row = row "'"$13"',"
		if ( i == 14 ) row = row "'"$14"',"
		if ( i == 15 ) row = row "'"$15"',"
		if ( i == 16 ) row = row "'"$16"',"
		if ( i == 17 ) row = row "'"$17"',"
		if ( i == 18 ) row = row "'"$18"',"
		if ( i == 19 ) row = row "'"$19"',"
		if ( i == 20 && $20 == "" ) row = row "null)"
		if ( i == 20 && $20 != "" ) row = row "CAST(\'"$20"\' AS DATETIME))"
	}
	print row >> outputfile
}

END {
	# Complete final output file
	print ""  >> outputfile
	print "go" >> outputfile
	
	for(i = 1; i <= outputfileno; i++) {
		outputfile = outputfilename outputfileno outputfileext
		close(outputfile)
	}
}