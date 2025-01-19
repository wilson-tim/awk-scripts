###############################################################################
#                                                                             #
# si_i.awk script VERSION 0.03                                                #
# (c) William Wragg/Datapro Software Ltd. 2003                                #
# BY WILLIAM WRAGG                                                            #
# DATE 20/11/2003                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#  awk -f si_i.awk ../si_f/si_f.txt > si_i.unl                                #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
#                                                                             #
# Local variables are declared as extra parameters in the parameter list of   #
# function definitions. The convention is to separate local variables from    #
# real parameters by extra spaces in the parameter list. But I use an         #
# underscore in front of the names of all local variables.                    #
#                                                                             #
# This script requires an implimentation of the UNIX sort function.           #
#                                                                             #
###############################################################################

BEGIN {
  FS = ","
  OFS = "|"
  
  #print "item_ref|site_ref|feature_ref|contract_ref|allocation_ref|priority_flag|volume|contract_value|occur_day|occur_week|occur_month|date_due|observation|round_c|pa_area|occur_no|variance|item_status|am_pm|prev_date|attachment|blank1|blank2|"
  
  # parse the jobtypes.txt for the volume info.
  file = "../jobtypes.txt"
  while ( (getline < file) > 0 ) {
    if ($1 != "Job Ref No.") {
      volume[$1] = $3
    }
  }
  close(file)

  # parse the sofmlist.txt for the jobs/feature link info.
  file = "../sofmlist.txt"
  while ( (getline < file) > 0 ) {
    if ($1 ~ /\"Feature :/) {
      gsub(/\"/,"",$1)
      split($1, feat_head, ":")
      feature_ref = truncate(feat_head[2])
      
      if (feature_ref != prev_feature_ref) {
        count = 0
        item_ref[feature_ref, 0] = 0
        prev_feature_ref = feature_ref
      }
    } else if ($1 == "\"SR-Ref \"") {
      continue
    } else {
      job_ref = truncate($1)
      if (! ((feature_ref, job_ref) in jobs) ) {
        jobs[feature_ref, job_ref] = "true"
        count++
        item_ref[feature_ref, 0] = count
        item_ref[feature_ref, count] = job_ref
      }
    }
  }
  close(file)

  # parse the sitefeat.csv for the gang info.
  file = "../sitefeat.csv"
  while ( (getline < file) > 0 ) {
    if ($1 ~ /Area Code:/) {
      gsub(/\"/,"",$4)
      site_ref = truncate($4)
    } else if ($1 == "Site Features List") {
      continue
    } else if ($1 == "Description ") {
      continue
    } else if ($1 == "") {
      continue
    } else {
      if ( !(site_ref in gang) && site_ref != "" ) {
        gsub(/\"/,"",$7)
        gang_ref = truncate($7)
        gang[site_ref] = gang_ref
      }
    }
  }
  close(file)

  FS = "|"
  OFS = "|"
}

# FUNCTION SECTION.
# -----------------
# This function chops off leading, and trailing, spaces from a string.
function truncate( string ) {
  sub(/^ +/,"",string)
  sub(/ *$/,"",string)
  return string
}
# ------------------------
# END OF FUNCTION SECTION.

# PATTERN SECTION.
# ----------------
NR > 1 {
  for ( i = 1; i <= item_ref[$1, 0]; i++) {
    print item_ref[$1, i], $2, $1, "GM", "NONE", "A", volume[ item_ref[$1, i] ], "", "ABCDEFG", "", "", "01/12/2003", "", gang[$2], "", "", "", "I", "", "", "", "", "|"
  }
}
# -----------------------
# END OF PATTERN SECTION.

END {}