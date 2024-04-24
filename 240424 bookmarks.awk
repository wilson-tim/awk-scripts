# 240424  TW  New script to analyse Edge, Chrome, etc. bookmarks html file

# $ awk -f bookmarks.awk Edge_favourites_23_04_2024.html > Edge_favourites_23_04_2024.txt
# $ awk -f bookmarks.awk Chrome_bookmarks_25_04_2024.html > Chrome_bookmarks_25_04_2024.txt

/H3 ADD_DATE=/ {
	# Datestamp
	match($0, /LAST_MODIFIED="[^"]*/);
	datestamp=substr($0, RSTART+15, RLENGTH-15);
	datestamp=strftime("%Y-%m-%d %H:%M:%S", datestamp);
	
	# Title
	match($0, /">[^</H3>]*/);
	title=substr($0, RSTART+2, RLENGTH-2);
	
	print "FOLDER" "\t" datestamp "\t" title "\t";
}

/A HREF=/ {
	# URL
	match($0, /HREF="[^"]*/);
	url=substr($0, RSTART+6, RLENGTH-6);
	
	# Datestamp
	match($0, /ADD_DATE="[^"]*/);
	datestamp=substr($0, RSTART+10, RLENGTH-10);
	datestamp=strftime("%Y-%m-%d %H:%M:%S", datestamp);
	
	# Title
	match($0, /">[^</A>]*/);
	title=substr($0, RSTART+2, RLENGTH-2);
	
	print "BOOKMARK" "\t" datestamp "\t" title "\t" url;
}
