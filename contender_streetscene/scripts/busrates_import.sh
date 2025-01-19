case $# in
0 )
	echo "\nUsage busrates_import.sh importfile"
	;;
* )
	# We can loop through the import files
	importfile=$1
	if [ -f $importfile ]
	then
		echo "Processing $importfile"

		# Convert the commas to pipes...
		echo "Processing "$importfile" unload"
		cat $1 |	$CCTDIR/SCRIPTS/rep > "$importfile"_a.unl
		if [ -f "$importfile"_a.unl ]
		then
			echo "importing"`wc -l $importfile"_a.unl`" files"
			$CCTDIR/SCRIPTS/popnum "$importfile"_a.unl "$importfile"_b.unl
			if [ -f "$importfile"_b.unl ]
			then
				echo fglgo_busrate_imp debug "$importfile"_b.unl
				fglgo_busrate_imp debug "$importfile"_b.unl
			else
				echo "$importfile"_b.unl notfound
			fi
		else
			echo "No business rate details to import"
		fi
	else
		echo "Import file not found."
	fi
esac
