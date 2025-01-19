##############################################################
#
# 09/11/2009  TW  Split GDACCESS trx file for groups 1 to 5
#                 into group specific GDACCESS trx files
#
# Usage:
#
# awk -f gdaccess.awk [gdaccess_filename].trx
#
#############################################################

# Set field separator as } and raise header processing flag
BEGIN { FS = "}"; header = "999"}

# Processing for header comment line (any other comment lines will be ignored)
/\*/ && header == "999" {header = $0; next}

# Processing for header line 0
/^0/ { header = header "\r\n" $0; next }

# Processing for header line 2s
/^2/ && header != "" { header = header "\r\n" $0; next } 

# Processing for first line 1: output header to all output files, lower header processing flag
/^1/ && header != "" {
	for(i = 1; i <= 5; i++) {
		print header > "gdaccess_"i".trx"
	}
	header = ""
}

# Processing for all line 1s
/^1/ { grpkey = substr($3, 3, 1); print $0 > "gdaccess_"grpkey".trx"; next }

# Processing for non header line 2s
/^2/ && header == "" { print $0 > "gdaccess_"grpkey".trx"; next}

# Close output files
END {
	for(i = 1; i <= 5; i++) {
		close("gdaccess_"i".trx")
	}
}