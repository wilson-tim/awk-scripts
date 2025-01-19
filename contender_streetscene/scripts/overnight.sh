:
# Contender Overnight Script
#
# Run via cron at 12:05 AM Monday to Sunday
# Created : 04/09/2003 ADJ

## Set up the environment #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
LOGFILE=/usr/universe/bin/overnight.log
PATH=$PATH:/usr/universe/bin:/usr/informix/bin
MAIL=/usr/spool/mail/`logname`
TERM=vt100
SHELL=ksh
export PATH MAIL TERM SHELL

. /usr/universe/bin/envinf
. $FGLDIR/envcomp

FGLGUI=0
export FGLGUI

## GENERAL TIDY-UP #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

# Do not remove spool files, /usr/universe/bin/mspool sorts out at 23:55
rm /tmp/10.*  

## LIVE DATABASE #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS 
export DBPATH DBBASE 

## bcheck and update statistics: CHECK AND FIX THE DATABASE
cd $DBPATH/universe.dbs
sh ./bcheck.exe

            dbaccess universe << EOF 2>&1
update statistics
EOF

## UPSII2 : Update si_i.date_due for scheduled tasks 

set > $LOGFILE
cd $CCTDIR/UPDTE_SI_I
fglrun upsii2

## NLPG : Process any waiting NLPG updates
#$CCTDIR/SCRIPTS/process_nlpg.sh >> $LOGFILE

## BLPU : Process any waiting BLPU updates
#$CCTDIR/SCRIPTS/process_blpu.sh >> $LOGFILE

## Update the contender friendly address
cd $CCTDIR/GIS_UTILS
fglrun gis_site12 >> $LOGFILE

## Update the Trade Site friendly address
cd $CCTDIR/GIS_UTILS
fglrun trade_addresses

## Update Trade contract values
cd  $CCTDIR/TRADE
fglrun value_agree

## Update Trade Revirew dates   
cd  $CCTDIR/TRADE
fglrun trade_agmt_review

## PDA Processing...
#$CCTDIR/SCRIPTS/process_auto_insp.sh >> /dev/null

## Create the orphan si_i delete script tonight (1 NOV 2004)
## /usr/universe/bin/orphan2.sh

# # BACKUP : Export the database(s)

cd $DBPATH/DBEXPORT
# Remove unwanted backup files
rm -r $DBPATH/DBEXPORT/universe.exp
rm -r $DBPATH/DBEXPORT/universe.exp.tar.Z
rm -r $DBPATH/DBEXPORT/universe.dbs
rm -r $DBPATH/DBEXPORT/dbexport.out

# Copy in the live database
cp -r $DBPATH/universe.dbs $DBPATH/DBEXPORT

# Export it...
dbexport universe

# Tar and compress it...
tar cvbf 20 universe.exp.tar universe.exp
compress $DBPATH/DBEXPORT/universe.exp.tar
chmod +r $DBPATH/DBEXPORT/universe.exp.tar.Z

## TRAINING DATABASE #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

DBPATH=/usr/universe/v7/databases/trainer
export DBPATH

## UPSII2 : Update si_i.date_due for scheduled tasks 

cd $CCTDIR/UPDTE_SI_I
fglrun upsii2

DATE=`date`
echo $DATE >>$LOGFILE
