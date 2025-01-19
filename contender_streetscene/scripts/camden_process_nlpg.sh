:
# Little script created by Andy Jones to process NLPG updates
# 11-Dec-2003

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

importscript=$CCTDIR/SCRIPTS/nlpg_import.sh
importdir=/usr/universe/v7/share/imports/NLPG/live
importlog=/usr/universe/v7/share/imports/NLPG/live/nlpg_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for importfile in `ls $importdir/*csv`
do
	echo $importfile >> $importlog
	$importscript $importfile >> $importlog
	mv $importfile $importdir/archive
	mv $importdir/*unl $importdir/archive
done

# Email the logfile

if [ -f $importlog ]
then
	mailit F andyj_datapro@lycos.co.uk "NLPG Imports `date`" $importlog
	mailit F bob@datapro.co.uk "NLPG Imports `date`" $importlog
	mailit F paul.hubbard@camden.gov.uk "NLPG Imports `date`" $importlog
	mailit F paul.D.Johnson@camden.gov.uk "NLPG Imports `date`" $importlog
fi
