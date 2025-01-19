BEGIN {
	print "" > "will.html" }

/<\/html>/ {
   print "       <p>Extra text added by the awk script." >> "will.html"
   print "       </p>" >> "will.html"
}

{ print $0 >> "will.html" }

END {
   close("will.html")
   system("c:/progra~1/netscape/commun~1/program/netscape c:/language/awk/awk_html/will.html")
}