##############################################################
#
# 23/02/2010  TW  Find maximum length of field 7
#
# Usage:
#
# awk -f NIStoAPAS.awk MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_EDIT2.txt > MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad_LEN.txt
#
# MASTER_MVDC_NIStoAPAS_PlanningHistoryLoad.txt file - | delimited
#
#############################################################



BEGIN { FS = "|"; maxlen = 0; maxlenfield = "" }

	NR == 1 { next }

    len = length($7)
    
    len > maxlen {
    	maxlen = len
    	maxlenfield = maxlen " " $1 " " $7
    	}
    	
END { print ""; print maxlenfield }


