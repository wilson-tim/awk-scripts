BEGIN {
	print "" > "will.html" }

{
   print $0 >> "will.html"
   close("will.html")
   cmd = "c:/progra~1/netscape/commun~1/program/netscape .\will.html"
   while ((cmd | getline capture_out) > 0) {
      close(cmd)
      print "boo"
      print capture_out
   }
}