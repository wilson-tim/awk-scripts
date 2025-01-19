set -x
case $# in
0 )
	echo "\nUsage accolade_locn_new.sh importfile"
	;;
* )
	importfile=$1
	if [ -f $importfile ]
	then
		echo "Processing $importfile"

		# Convert the commas to pipes...
		echo "$importfile: Upshift"
		dd if=$importfile of="$importfile".ucase conv=ucase
		echo "$importfile: Remove blank lines"
		cat "$importfile".ucase | sed -e /^$/d > "$importfile".num
		popnum "$importfile".num $importfile
		rm "$importfile"\.ucase
		rm "$importfile"\.num
		echo fglgo_gis_locn_new debug $importfile
		fglgo_gis_locn_new debug $importfile
	else
		echo "Import file not found."
	fi
esac
