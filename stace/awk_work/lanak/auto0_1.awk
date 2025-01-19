BEGIN {
   # initialize the field separator
   FS = "|"; OFS = " "
  
   configfile = ARGV[1]
   sub(/\....$/, "", configfile)
   configfile = configfile ".cfg"
 
   # set up and array to show where each screen field is held in the .asc file 
   while ( (getline < configfile) > 0) {
      #total number of fields to go through on form
      if ($1 == "@") {total = $2}
      else {
      # set up and array 
         for (count = 1; count <= total; count++) {form[count] = $count}
      }
   }
   
   close(configfile)
}


# FUNCTION SECTION
# remove preceding and trailing spaces
function chop(string) {
   sub(/^ +/, "", string)
   sub(/ +$/, "", string)
   return string
}

{
   # initialize form into add update mode
   printf "\033ca"

   # Cycle through each of the fields and pick out the info to type in
   for (count = 1; count <= total; count++) {
      chopped = chop($form[count])
      if (chopped == "" || chopped ~ /\*+/) {printf "\r"}
      else {printf chopped "\r"}
   }

   # add the record
   print "\033au"

}

END {
   # leave pharaoh
   printf "\033pF\033pF"
}
