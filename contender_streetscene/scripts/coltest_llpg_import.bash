case $# in
0 )
	echo "\nUsage nlpg_import.bash importfile"
	;;
* )
	echo "llpg_import.bash"
	
	# Frig so that 4js licencing will work
	OLDFGL=$FGLDIR
	FGLDIR=D:\\DES\\Contender\\FourJs\\f4gl
	# Undone at the end of tis script just in case

	# We can loop through the import files
	importfile=$1
	importfile_root=`echo $1 | sed -e "s/.csv$//"`
	if [ -f $importfile ]
	then
		echo "Processing $importfile"

		# Convert the commas to pipes...
		echo "Processing nlpg11_locn unload"
#		grep "^11" $1 |	sed -e s/,/\|/g > "$importfile_root"_11
		grep "^11" $1 |	$CCTDIR\\SCRIPTS\\rep > "$importfile_root"_11
		if [ -f "$importfile_root"_11 ]
		then
			echo "importing"`wc -l "$importfile_root"_11`" files"
			pr -n\| -t ${importfile_root}_11 | sed -e "s/^  *//" > ${importfile_root}_11a
			if [ -f "$importfile_root"_11a ]
			then
				echo fglgo_nlpg11_locn debug "$importfile_root"_11a
				cd $CCTDIR\\GIS_IMPORT
				pwd
				echo fglrun nlpg11_locn debug "$importfile_root"_11a
				cp "$importfile_root"_11a "$importfile_root"_11a.unl
				fglrun nlpg11_locn debug "$importfile_root"_11a
#				fglgo_nlpg11_locn.bat debug "$importfile_root"_11a
			else
				echo "$importfile_root"_11a notfound
			fi
			if [ -f "$importfile_root"_11a_1.unl ]
			then
				echo fglgo_gis_locn_new debug "$importfile_root"_11a_1.unl
			cd $CCTDIR\\GIS_IMPORT
			fglrun gis_locn_new debug "$importfile_root"_11a_1.unl
#				fglgo_gis_locn_new debug "$importfile_root"_11a_1.unl
			else
				echo "$importfile_root"_11a_1.unl notfound
			fi
			if [ -f "$importfile_root"_11a_2.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile_root"_11a_2.unl
			cd $CCTDIR\\GIS_IMPORT
			fglrun gis_site_new debug "$importfile_root"_11a_2.unl
#				fglgo_gis_site_new debug "$importfile_root"_11a_2.unl
			else
				echo "$importfile_root"_11a_2.unl notfound
			fi
		else
			echo "No location entries to import"
		fi

		echo "Processing nlpg24_site unload"
#		grep "^24" $1 |	sed -e s/,/\|/g > "$importfile_root"_24
		grep "^24" $1 |	$CCTDIR\\SCRIPTS\\rep > "$importfile_root"_24
		if [ -f "$importfile_root"_24 ]
		then
			echo "importing"`wc -l "$importfile_root"_24`" files"
			pr -n\| -t ${importfile_root}_24 | sed -e "s/^  *//" > ${importfile_root}_24a
			if [ -f "$importfile_root"_24a ]
			then
				echo fglgo_nlpg24_site debug "$importfile_root"_24a
			cd $CCTDIR\\GIS_IMPORT
			fglrun nlpg24_site debug "$importfile_root"_24a
#				fglgo_nlpg24_site debug "$importfile_root"_24a
			else
				echo "$importfile_root"_24a notfound
			fi
			if [ -f "$importfile_root"_24a_1.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile_root"_24a_1.unl
			cd $CCTDIR\\GIS_IMPORT
			fglrun gis_site_new debug "$importfile_root"_24a_1.unl
#				fglgo_gis_site_new debug "$importfile_root"_24a_1.unl
			else
				echo "$importfile_root"_24a_1.unl notfound
			fi
		else
			echo "No site entries to import"
		fi

		echo "Processing nlpg21_site_detail unload"
#		grep "^21" $1 |	sed -e s/,/\|/g > "$importfile_root"_21
		grep "^21" $1 |	$CCTDIR\\SCRIPTS\\rep > "$importfile_root"_21
		if [ -f "$importfile_root"_21 ]
		then
			echo "importing"`wc -l "$importfile_root"_21`" files"
			pr -n\| -t ${importfile_root}_21 | sed -e "s/^  *//" > ${importfile_root}_21a
			if [ -f "$importfile_root"_21a ]
			then
				echo fglgo_nlpg21_site_detail debug "$importfile_root"_21a
			cd $CCTDIR\\GIS_IMPORT
			fglrun nlpg21_site_detail debug "$importfile_root"_21a
#				fglgo_nlpg21_site_detail debug "$importfile_root"_21a
			else
				echo "$importfile_root"_21a notfound
			fi
			if [ -f "$importfile_root"_21a_1.unl ]
			then
				echo fglgo_gis_site_new debug "$importfile_root"_21a_1.unl
			cd $CCTDIR\\GIS_IMPORT
			fglrun gis_site_new debug "$importfile_root"_21a_1.unl
#				fglgo_gis_site_new debug "$importfile_root"_21a_1.unl
			else
				echo "$importfile_root"_21a_1.unl notfound
			fi
		else
			echo "No site detail entries to import"
		fi
	else
		echo "Import file not found."
	fi

	# see Frig at top of code
	FGLDIR=$OLDFGL
esac
