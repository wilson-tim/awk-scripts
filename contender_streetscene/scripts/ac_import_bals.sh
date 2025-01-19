case $# in
0 )
	echo "\nUsage ac_import_bals.sh importfile"
	;;
* )
	# We can loop through the import files
	importfile=$1
	if [ -f $importfile ]
	then
		echo "Processing $importfile"

		# Convert the tabs to pipes and remove ^M...
		cat $1 | sed -e s/\	/\|/g | sed -e s/$/\|/g | sed -e s/// > "$importfile".unl
		$CCTDIR/SCRIPTS/popnum "$importfile".unl "$importfile"_a.unl
		if [ -f "$importfile"_a.unl ]
		then
			exec fglgo_invc_balances debug "$importfile"_a.unl
		else
			echo "$importfile"_a.unl notfound
		fi
	else
		echo "Import file not found."
	fi
esac
