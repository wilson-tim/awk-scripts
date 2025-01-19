BEGIN {}

$1 ~ /^\[[0-9]+;[0-9]+H/ {
   mid=index($0,";")
   end=index($0,"H")
   x=substr($0,mid + 1 ,((end - 1) - mid))
   y=substr($0,2,mid - 2)
   sub(/^\[[0-9]+;[0-9]+H/,"",$0)
   screen[x,y]=$0

   for ( j=1; j<=24; j++) {
      for (i=1; i<=80; i++) { 
         printf screen[i,j]
      }
      print
   }

   next } 
