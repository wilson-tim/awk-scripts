case $# in
0 )
	echo "\nUsage cambs_blpu_import.sh importfile"
	;;
* )
	# We can loop through the import files
	importfile=$1
	# Get rid of any control-m and double-quote characters
	cat $importfile | sed 's//,,/g' | sed 's/\"//g'  > $importfile\.proc
	# Force all data to upper case letters
	dd if=$importfile\.proc of=$importfile conv=ucase
	rm $importfile\.proc
	# Insert an incrementally numbered column at start of each row
	$CCTDIR/SCRIPTS/popnum $importfile "$importfile".num ,
	mv "$importfile".num $importfile
	if [ -f $importfile ]
	then
		echo "Processing $importfile with" `wc -l $importfile`" records"
		fglgo_blpu_import debug $importfile
	else
		echo "Import file not found."
	fi
esac
