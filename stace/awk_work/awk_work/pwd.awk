BEGIN { commt = 0; OFMT = "%.2f" }
{ 
   commt = commt + $3
   if ( $3 < 0 ) { print $0 } 
}
END { print commt }
   
