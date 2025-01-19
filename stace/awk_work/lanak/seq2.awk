BEGIN {
   FS = "|"; OFS = "|" 
}

{
   if ($12 in type) {next}
   else {
      print $12, "PWD's " NR
      type[$12] = NR
   }
}

END {}
