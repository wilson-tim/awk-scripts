##############################################################
#
# 27/04/2011  TW  Create SQL script to import data
#                 from EHPWFREQB.txt file
#
# Usage:
#
# The source data .txt file columns are | (bar) delimited
# Prepare the source data .txt file by replacing all double quotes with nulls
# and all the single quotes with two single quotes
#
# awk -f EHPWFREQB.awk EHPWFREQB.txt
# gawk -f EHPWFREQB.awk EHPWFREQB.txt
#
##############################################################

BEGIN {FS = "\|"}

# Use if header row is present in source data .txt file
NR == 1 { next }

{print "insert into ehpwfreqb (pk, u_version, vminvol, vmaxvol, pwfreqc, pwfreqa) values ("NR - 1", \'\!\', "$1", "$2", "$3", "$4")" > "EHPWFREQB.sql" }

END {
	print "go" > "EHPWFREQB.sql"
	close("EHPWFREQB.sql")

}