:
# Little script created by Andy Jones to process ENF income updates
# 01-Nov-2006

sharedir=/usr/universe/v7/share
importdir=$sharedir/imports/ENFORCE
importlog=$sharedir/imports/ENFORCE/enf_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for importfile in `ls $importdir/*dat | sort -n`
do
	echo $importfile >> $importlog
	cat $importfile | sed -e '$d' > $importfile.new
	popnum $importfile.new $importfile ,
#	fglrun $CCTDIR/ENFORCE/enf_payment_in $importfile >> $importlog
#	fglrun $CCTDIR/ENFORCE_NEW/enf_payment_in debug $importfile 
	fglrun $CCTDIR/ENFORCE/enf_payment_in debug $importfile 
	mv $importfile $importdir/archive
	mv $importdir/*new $importdir/archive
done

# Email the logfile

# mailit $importlog paul.hubbard@camden.gov.uk
