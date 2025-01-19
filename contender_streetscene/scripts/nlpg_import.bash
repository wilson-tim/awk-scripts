case $# in
0 )
	echo "\nUsage nlpg_import.bash importfile"
	;;
* )
	echo "llpg_import.bash"

	# We can loop through the import files
	importfile=$1
	if [ -f $importfile ]
	then
		echo "Processing $importfile"

		# Convert the commas to pipes...
		echo "Processing nlpg11_locn unload"
#		grep "^11" $1 |	sed -e s/,/\|/g > "$importfile"_11.unl
		grep "^11" $1 |	$CCTDIR\SCRIPTS\rep > "$importfile"_11.unl
		if [ -f "$importfile"_11.unl ]
		then
			echo "importing"`wc -l $importfile"_11.unl`" files"
			$CCTDIR\SCRIPTS\popnum "$importfile"_11.unl "$importfile"_11a.unl
			if [ -f "$importfile"_11a.unl ]
			then
				echo fglgo_nlpg11_locn debug "$importfile"_11a.unl
				fglgo_nlpg11_locn debug "$importfile"_11a.unl
			else
				echo "$importfile"_11a.unl notfound
			fi
			if [ -f "$importfile"_11a.unl_1.unl ]
			then
				echo fglgo_gis_locn_new debug "$importfile"_11a.unl_1.unl
				fglgo_gis_locn_new debug "$importfile"_11a.unl_1.unl
			else
				echo "$importfile"_11a.unl_1.unl notfound
			fi
			if [ -f "$importfile"_11a.unl_2.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile"_11a.unl_2.unl
				fglgo_gis_site_new debug "$importfile"_11a.unl_2.unl
			else
				echo "$importfile"_11a.unl_2.unl notfound
			fi
		else
			echo "No location entries to import"
		fi

		echo "Processing nlpg24_site unload"
#		grep "^24" $1 |	sed -e s/,/\|/g > "$importfile"_24.unl
		grep "^24" $1 |	$CCTDIR\SCRIPTS\rep > "$importfile"_24.unl
		if [ -f "$importfile"_24.unl ]
		then
			echo "importing"`wc -l $importfile"_24.unl`" files"
			$CCTDIR\SCRIPTS\popnum "$importfile"_24.unl "$importfile"_24a.unl
			if [ -f "$importfile"_24a.unl ]
			then
				echo fglgo_nlpg24_site debug "$importfile"_24a.unl
				fglgo_nlpg24_site debug "$importfile"_24a.unl
			else
				echo "$importfile"_24a.unl notfound
			fi
			if [ -f "$importfile"_24a.unl_1.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile"_24a.unl_1.unl
				fglgo_gis_site_new debug "$importfile"_24a.unl_1.unl
			else
				echo "$importfile"_24a.unl_1.unl notfound
			fi
		else
			echo "No site entries to import"
		fi

		echo "Processing nlpg21_site_detail unload"
#		grep "^21" $1 |	sed -e s/,/\|/g > "$importfile"_21.unl
		grep "^21" $1 |	$CCTDIR\SCRIPTS\rep > "$importfile"_21.unl
		if [ -f "$importfile"_21.unl ]
		then
			echo "importing"`wc -l $importfile"_21.unl`" files"
			$CCTDIR\SCRIPTS\popnum "$importfile"_21.unl "$importfile"_21a.unl
			if [ -f "$importfile"_21a.unl ]
			then
				echo fglgo_nlpg21_site_detail debug "$importfile"_21a.unl
				fglgo_nlpg21_site_detail debug "$importfile"_21a.unl
			else
				echo "$importfile"_21a.unl notfound
			fi
			if [ -f "$importfile"_21a.unl_1.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile"_21a.unl_1.unl
				fglgo_gis_site_new debug "$importfile"_21a.unl_1.unl
			else
				echo "$importfile"_21a.unl_1.unl notfound
			fi
		else
			echo "No site detail entries to import"
		fi
	else
		echo "Import file not found."
	fi
esac
