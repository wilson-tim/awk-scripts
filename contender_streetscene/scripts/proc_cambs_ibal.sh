:
# Little script created by Andy Jones to process NLPG updates
# 11-Dec-2003

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin:/etc
TERM=vt100
SHELL=ksh
MAIL=/usr/spool/mail/`logname`          # mailbox location
export PATH TERM SHELL MAIL

INFORMIXDIR=/usr/informix
INFORMIXSERVER=cambrid
EDITOR=vi
DBMONEY=£
DBDATE=DMY4/
DBTEMP=/usr/universe/v7/DBTEMP/live
FGLDIR=/usr/fgl2c
CCTDIR=/usr/universe/v7/standard
export INFORMIXDIR INFORMIXSERVER EDITOR DBMONEY DBTEMP FGLDIR CCTDIR DBDATE

. $FGLDIR/envcomp

FGLLDPATH=/usr/universe/v7/standard/modules
export FGLLDPATH

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

# importscript=$CCTDIR/SCRIPTS/nlpg_import.sh
importdir=/usr/universe/v7/share/imports/AC
importlog=$importdir/nlpg_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# date >> $importlog
# echo "Starting NLPG import process" >> $importlog

# Process any waiting files
# changed 0505 csv to 05 csv to cover oside boundary files

for importfile in `ls $importdir/IBAL*csv`
do
        echo $importfile >> $importlog
        fglrun invc_balances debug $importfile
        mv $importfile $importdir/archive
done

# Email the logfile

if [ -f $importlog ]
then
	mailit F david.hopkins@cambridge.gov.uk "Accounts Balances Import `date`" $importlog
	mailit F bernard.gravett@btinternet.com "Accounts Balances Import `date`" $importlog
fi
