##############################################################
#
# 12/04/2011  TW  Create SQL script to import data
#                 from PARAMCODE.txt file
#
# Usage:
#
# The source data .txt file columns are | (bar) delimited
# Prepare the source data .txt file by replacing all double quotes with nulls
# and all the single quotes with two single quotes
#
# awk -f PARAMCODE.awk PARAMCODE.txt
# gawk -f PARAMCODE.awk PARAMCODE.txt
#
#############################################################

BEGIN {FS = "\|"}

# Use if header row is present in source data .txt file
NR == 1 { next }

{print "insert into ehpwtest (pwtestkey, u_version, pwtestdesc, pwtestpcx, pwtestunits) values (\'"$1"\', \'\!\', \'"$2"\', "$4", \'"$3"\')" > "PARAMCODE_ehpwtest.sql" }

{print "insert into ehsamlist2 (pk, sample, u_version) values (\'W\', \'"$1"\', \'\!\')" > "PARAMCODE_ehsamlist2.sql" }

END {
	print "go" > "PARAMCODE_ehpwtest.sql"
	close("PARAMCODE_ehpwtest.sql")

	print "go" > "PARAMCODE_ehsamlist2.sql"
	close("PARAMCODE_ehsamlist2.sql")
}