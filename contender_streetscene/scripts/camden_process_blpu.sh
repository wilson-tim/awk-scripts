:
# Copy of a little script created by Andy Jones modified to process BLPU updates
# 04-Jun-2004

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin
TERM=vt100
SHELL=ksh
export PATH TERM SHELL

. /usr/universe/bin/envinf
. $FGLDIR/envcomp

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

importscript=$CCTDIR/SCRIPTS/blpu_import.sh
importdir=/usr/universe/v7/share/imports/BLPU/live/
importlog=/usr/universe/v7/share/imports/BLPU/live/blpu_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for importfile in `ls $importdir/*.txt | sort`
do
	echo $importfile >> $importlog
	$importscript $importfile >> $importlog
	mv $importfile $importdir/archive
done

# Email the logfile

if [ -f $importlog ]
then
	mailit F andyj_datapro@lycos.co.uk "BLPU Imports `date`" $importlog
	mailit F bob@datapro.co.uk "BLPU Imports `date`" $importlog
	mailit F paul.hubbard@camden.gov.uk "BLPU Imports `date`" $importlog
	mailit F Paul.D.Johnson@camden.gov.uk "BLPU Imports `date`" $importlog
fi
