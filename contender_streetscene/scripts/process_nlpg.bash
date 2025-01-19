:
# Little script created by Andy Jones to process NLPG updates
# 11-Dec-2003

importscript=$CCTDIR/SCRIPTS/nlpg_import.bash
importdir=$DBPATH/NLPG
importlog=$DBPATH/NLPG/nlpg_import_`date | awk '{print $3"-"$2"-"$6}'`.log
index=5210_
fn=$importdir/$index

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
