##############################################################
#
# 16/11/2009  TW  Analyse GDACCESS trx file for records
#                 relating to CMPARAMS table
#
# Usage:
#
# awk -f gdaccess.awk [gdaccess_filename].trx
#
#############################################################

# Raise header processing flag
BEGIN { header = "999"}

# Processing for header comment line (any other comment lines will be ignored)
/\*/ && header == "999" {header = $0; next}

# Processing for header line 0
/^0/ { header = header "\r\n" $0; next }

# Processing for header line 2s
/^2/ && header != "" { header = header "\r\n" $0; next } 

# Processing for first line 1: output header to all output files, lower header processing flag
/^1/ && header != "" {
	print header > "test2.trx"
	header = ""
}

# Processing for all line 1s
/^1/ && /CMPARAMS\_/ { cmparams = 1; print $0 > "test2.trx"; next }
/^1/ && /[^CMPARAMS\_]/ { cmparams = 0; next }

# Processing for non header line 2s
/^2/ && header == "" && cmparams == 1 { print $0 > "test2.trx"; next}

# Close output files
END {
	close("test2.trx")
}