BEGIN {
   FS = "|"; OFS = "|" 
}

{
   if ($24 in type) {next}
   else {
      print $24, "PWD's " NR
      type[$24] = NR
   }
}

END {}
