:
# Copy of a little script created by Andy Jones modified to process BLPU updates
# 04-Jun-2004

echo process_blpu $*

importscript=$CCTDIR/SCRIPTS/blpu_import.bash
importdir=$ROOTDIR/version7/share/IMPORTS/BLPU/$ENV
cygimport=$CYGROOT/version7/share/IMPORTS/BLPU/$ENV

importlog=$LOGDIR/blpu_import_`date | awk '{print $3"-"$2"-"$6}'`.log
# index=5210_
# fn=$importdir/$index

# Process any waiting files

# for importfile in `ls $importdir/*csv | sed -e "s@$fn@@g" | sort -n`
for importfile in `ls $cygimport/*.txt | sort`
do
#	echo $fn$importfile >> $importlog
	echo $importfile >> $importlog
#	bash $importscript $fn$importfile >> $importlog
	bash $importscript $importfile >> $importlog
#	mv $fn$importfile $importdir/archive
	mv $importfile $importdir/archive
#	mv $importdir/*unl $importdir/archive
done

# Email the logfile

# mailit $importlog paul.hubbard@camden.gov.uk
