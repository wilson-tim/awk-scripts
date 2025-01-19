:
# Little script created by Andy Jones to process LLPG updates
# 11-Dec-2003 Mods - PG / FK 23-03-06
#
# Currently only runs from within "overnight.bash" - for standalone 
# you need to add extra variable up front
#

echo process_llpg $*

importscript=$ROOTDIR/standard/scripts/llpg_import.bash
importdir=$ROOTDIR/share/IMPORTS/LLPG/${ENV}
cygimport=$CYGROOT/share/IMPORTS/LLPG/${ENV}
importlog=$LOGDIR/llpg_import_`date | awk '{print $3"-"$2"-"$6}'`.log
index=5030_
#fn=$importdir/$index
fn=$cygimport/$index


# Process any waiting files
for importfile in `ls $cygimport/*csv | sed -e "s@$fn@@g" | sort `
do
	echo $fn$importfile
	echo $fn$importfile >> $importlog
	bash $importscript $fn$importfile >> $importlog
	mv $fn$importfile $importdir/archive
	mv $importdir/*unl $importdir/archive
done
# Email the logfile

# mailit $importlog fiona@datapro.co.uk
