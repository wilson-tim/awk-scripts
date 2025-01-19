:
# Copy of a little script created by Andy Jones modified to process BLPU updates
# 04-Jun-2004

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin
TERM=vt100
SHELL=ksh

# MAIL=/usr/spool/mail/`logname`          # mailbox location
export PATH TERM SHELL # MAIL

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

importscript=$CCTDIR/SCRIPTS/cambs_blpu_import.sh
importdir=/usr/universe/v7/share/imports/BLPU
importlog=/usr/universe/v7/share/imports/BLPU/blpu_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for importfile in `ls $importdir/BLPU*.csv | sort`
do
	echo $importfile >> $importlog
	$importscript $importfile >> $importlog
	mv $importfile $importdir/archive
done

# Email the logfile

if [ -f $importlog ]
then
	mailit F david.hopkins@cambridge.gov.uk "BLPU Imports `date`" $importlog
	mailit F bernard.gravett@btinternet.com "BLPU Imports `date`" $importlog
fi
