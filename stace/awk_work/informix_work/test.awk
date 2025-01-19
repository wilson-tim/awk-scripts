{
   if (length($1) > 18) {
      $1 = "\t" substr($1,1,18)
   }
   print $0
}
