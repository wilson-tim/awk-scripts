###############################################################################
#
# This script updates the insp_list contender table with the inspection list
# for the pda-in-cam webapp. It also uses the *.sql files in pda/
#
# The script should be called with nohup and run as a background process:
#
# nohup /usr/universe/bin/insp_list_upd.sh &
#
# The variable CONTENDERBIN is the directory where this script resides along
# with the pda/ directory for the SQL files.
#
# NOTE: The four variables below must be setup correctly for the script to
# work.
#
###############################################################################
# setup the variables needed to run sql against the specified database.
INFORMIXDIR=/usr/informix
INFORMIXSERVER=odin
CONTENDERBIN=/usr/universe/bin
DBPATH=/usr/universe/v7/databases/CAMDEN
export INFORMIXDIR INFORMIXSERVER CONTENDERBIN DBPATH

while true
do
  # add defaults
  $INFORMIXDIR/bin/dbaccess universe $CONTENDERBIN/pda/insp_list_defs.sql > $CONTENDERBIN/pda/update.log 2>&1

  # add inspections
  $INFORMIXDIR/bin/dbaccess universe $CONTENDERBIN/pda/insp_list_insps.sql >> $CONTENDERBIN/pda/update.log 2>&1

  # add samples
  $INFORMIXDIR/bin/dbaccess universe $CONTENDERBIN/pda/insp_list_samps.sql >> $CONTENDERBIN/pda/update.log 2>&1

  # do the update
  $INFORMIXDIR/bin/dbaccess universe $CONTENDERBIN/pda/do_update.sql >> $CONTENDERBIN/pda/update.log 2>&1

  # sleep fo 5 mins (300 secs)
  sleep 300
done

rm -f $CONTENDERBIN/pda/update.log

