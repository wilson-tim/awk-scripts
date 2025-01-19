:
# Script to process Business Rates extract files
# 08-Mar-2008

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
# DBPATH=/u1/universe/version7/databases/CAMDEN - BJG test value only
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

importscript=$CCTDIR/SCRIPTS/busrates_import.sh
importdir=$DBPATH/BUSINESS_RATES
importlog=$DBPATH/BUSINESS_RATES/busrates_import_`date | awk '{print $3"-"$2"-"$6}'`.log
fn=$importdir/

# Process any waiting files

for importfile in `ls $importdir/*csv | sed -e "s@$fn@@g" | sort -n`
do
	echo $fn$importfile >> $importlog
	$importscript $fn$importfile >> $importlog
	mv $fn$importfile $importdir/archive
	mv $importdir/*unl $importdir/archive
done

# Email the logfile

# mailit $importlog paul.hubbard@camden.gov.uk
