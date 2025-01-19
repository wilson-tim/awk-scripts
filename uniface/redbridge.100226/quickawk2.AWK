##############################################################
#
# 01/03/2010  TW  Quick AWK for Redbridge data
#
# Usage:
#
# awk -f quickawk2.awk PLANES_MATCHED_TO_LLPG_UPRN_ONLY.txt > QUICKAWK2.txt
#
# PLANES_MATCHED_TO_LLPG_UPRN_ONLY.txt file - | delimited
#
#############################################################




BEGIN { FS = "|"; maxlen = 0; maxlenfield = "" }

	NR == 1 { next }

    len = length($9)
    
    len > maxlen {
    	maxlen = len
    	maxlenfield = maxlen " " $1 " " $9
    	}
    	
END { print ""; print maxlenfield }


