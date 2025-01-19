##############################################################
#
# 07/06/2010  TW  Quick AWK for Redbridge data
#
# Usage:
#
# gawk -f quickawk2.awk CopytblPLANES_MATCHED_WITH_CODES_AND_DESCRIPTIONS.txt > QUICKAWK2.txt
#
# CopytblPLANES_MATCHED_WITH_CODES_AND_DESCRIPTIONS.txt file - | delimited
#
#############################################################




BEGIN { FS = "|"; maxlen = 0; maxlenfield = "" }

	NR == 1 { next }

    len = length($0)
    
    len > maxlen {
    	maxlen = len
    	maxlenfield = maxlen " " $0
    	}
    	
END { print ""; print maxlenfield }


