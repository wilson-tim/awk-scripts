:
# Script created by Bernard Gravett to process Accounts Balances feedback
# 30 July 2007

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin:/etc
TERM=vt100
SHELL=ksh
export PATH TERM SHELL

INFORMIXDIR=/usr/informix
INFORMIXSERVER=odin   
EDITOR=vi
DBMONEY=£
DBDATE=DMY4/
DBTEMP=/usr/universe/v7/DBTEMP/CAMBRIDGE
FGLDIR=/usr/fgl2c
CCTDIR=/usr/universe/v7/standard
export INFORMIXDIR INFORMIXSERVER EDITOR DBMONEY DBTEMP FGLDIR CCTDIR DBDATE

. $FGLDIR/envcomp

FGLLDPATH=/usr/universe/v7/standard/modules
export FGLLDPATH

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/CAMBRIDGE
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

importscript1=$CCTDIR/SCRIPTS/ac_import_bals.sh
importscript2=$CCTDIR/SCRIPTS/ac_import_addr.sh
importdir=/usr/universe/v7/share/imports/AC/CAMBRIDGE
importlog=$importdir/acimport_`date | awk '{print $3"-"$2"-"$6}'`.log

# date >> $importlog

# Process any waiting files

echo "Starting AC Balance Import process" >> $importlog
if [ -f $importdir/INVCRET*.txt ]
then
	for importfile in `ls $importdir/INVCRET*.txt`
	do
        echo $importfile >> $importlog
        $importscript1 $importfile >> $importlog
        mv $importfile $importdir/archive
        rm $importdir/*.unl
	done
else
	echo "No AC Balance Import files found" >> $importlog
fi

echo "Starting AC Address Import process" >> $importlog
if [ -f $importdir/INVCINFO*.txt ]
then
	for importfile in `ls $importdir/INVCINFO*.txt`
	do
        echo $importfile >> $importlog
        $importscript2 $importfile >> $importlog
        mv $importfile $importdir/archive
        rm $importdir/*.unl
	done
else
	echo "No AC Address Import files found" >> $importlog
fi
echo "Ending AC Import processing" >> $importlog

