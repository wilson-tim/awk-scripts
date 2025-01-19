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

DBPATH=/usr/universe/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

importscript=$CCTDIR/SCRIPTS/blpu_import.sh
importdir=$DBPATH/BLPU
importlog=$DBPATH/BLPU/blpu_import_`date | awk '{print $3"-"$2"-"$6}'`.log
# index=5210_
# fn=$importdir/$index

# Process any waiting files

# for importfile in `ls $importdir/*csv | sed -e "s@$fn@@g" | sort -n`
for importfile in `ls $importdir/*.txt | sort`
do
#	echo $fn$importfile >> $importlog
	echo $importfile >> $importlog
#	$importscript $fn$importfile >> $importlog
	$importscript $importfile >> $importlog
#	mv $fn$importfile $importdir/archive
	mv $importfile $importdir/archive
#	mv $importdir/*unl $importdir/archive
done

# Email the logfile

# mailit $importlog paul.hubbard@camden.gov.uk
