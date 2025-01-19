BEGIN {
   while ( (getline < "video.dat") > 0 ) {
      if ($1 != "term") {
         gsub(/\\E/,"\033",$2)
         attr[$1] = $2 } } }

{
   print attr["Vi"] "hello" attr["Va"] " hello" }

END {}
