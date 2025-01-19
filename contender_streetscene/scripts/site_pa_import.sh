case $# in
0 )
	echo "\nUsage site_pa_import.sh importfile"
	;;
* )
	# We can loop through the import files
	importfile=$1
	cat $importfile | sed '1d' | sed 's///g' | sed 's/\"//g'  > $importfile\.proc
	dd if=$importfile\.proc of=$importfile conv=ucase
	rm $importfile\.proc
	$CCTDIR/SCRIPTS/popnum $importfile "$importfile".num ,
	mv "$importfile".num $importfile
	if [ -f $importfile ]
	then
		echo "Processing $importfile with" `wc -l $importfile`" records"
		fglgo_site_pa_import $importfile ,
	else
		echo "Import file not found."
	fi
esac
