# 240424  TW  New script to analyse Edge bookmarks html file

# $ awk -f bookmarks.awk Edge_favourites_23_04_2024.html > bookmarks.txt

/H3 ADD_DATE=/ {
	# Datestamp
	match($0, /LAST_MODIFIED="[^"]*/);
	datestamp=substr($0, RSTART+15, RLENGTH-15);
	datestamp=strftime("%Y-%m-%d %H:%M:%S", datestamp);
	
	# Title
	match($0, /">[^</]*/);
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
	match($0, /">[^</]*/);
	title=substr($0, RSTART+2, RLENGTH-2);
	
	print "BOOKMARK" "\t" datestamp "\t" title "\t" url;
}
