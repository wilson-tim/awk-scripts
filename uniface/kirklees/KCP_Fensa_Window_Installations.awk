##############################################################
#
# 14/12/2009  TW  Create SQL script to import data
#                 from KCP_Fensa_Window_Installations.txt file
# 15/12/2009  TW  Output in blocks of 10000 records
#
# Usage:
#
# The source data .txt file columns are | (bar) delimited
# Prepare the source data .txt file by replacing all double quotes with nulls
# and all the single quotes with two single quotes
#
# awk -f KCP_Fensa_Window_Installations.awk KCP_Fensa_Window_Installations.txt
#
#############################################################

BEGIN {FS = "\|"}

# Use if header row is present in source data .txt file
# NR == 1 { next }

# Check for duff dates
# $7!="" && match($7, /^2/) == 0 { print NR "   " $7 }

$7=="" {print "insert into KCP_Fensa_Window_Installations (ID, Address_Line_1, Address_Line_2, Address_Line_3, Address_Line_4, Postcode, Date_Work_Completed, Description_Of_Work_Item, Door_Count, Add_match, UPRN) values (\'"$1"\', \'"$2"\', \'"$3"\', \'"$4"\', \'"$5"\', \'"$6"\', NULL, \'"$8"\', \'"$9"\', \'"$10"\', \'"$11"\')" > "KCP_Fensa_Window_Installations_"filenocalc()".sql" }
$7!="" {print "insert into KCP_Fensa_Window_Installations (ID, Address_Line_1, Address_Line_2, Address_Line_3, Address_Line_4, Postcode, Date_Work_Completed, Description_Of_Work_Item, Door_Count, Add_match, UPRN) values (\'"$1"\', \'"$2"\', \'"$3"\', \'"$4"\', \'"$5"\', \'"$6"\', CAST(\'"$7"\' AS DATETIME), \'"$8"\', \'"$9"\', \'"$10"\', \'"$11"\')" > "KCP_Fensa_Window_Installations_"filenocalc()".sql" }

END {
	for(i = 1; i <= lastfileno; i++) {
		print "go" > "KCP_Fensa_Window_Installations_"i".sql"
		close("KCP_Fensa_Window_Installations_"i".sql")
	}
}

function filenocalc(fileno)
{
	fileno = int(NR/10000)
	fileno ++ 1
    lastfileno = fileno

    #fileno = NR / 10000
    # Extract the integer part of the result of the calculation
    #n = split(fileno, resultarray, "\.")
    #fileno = resultarray[1] + 1
    
    return fileno
}
