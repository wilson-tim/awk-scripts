BEGIN {
   level = 2
   print "Welcome to level " level }

/:q/ || /:pf/ {
   print "Quitting Level " level " ..."
   exit }

/:p/ {
   print "Level " level }

/:nf/ {
   cmd = "awk -f level" (level + 1) ".awk"
   system(cmd) }
