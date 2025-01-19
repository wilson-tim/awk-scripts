##############################################################################
# Call the program like;
#
# awk -f auto.awk <tablename.asc> > <tablename.dat>
#
# e.g.  awk -f auto.awk sp_type.asc > sp_type.dat
#
# This program uses a configuration file <tablename.cfg> whose fisrt line
# starts with a '@' symbol followed by a pipe symbol '|' followed by how many
# fields there are in the form. The second line is a pipe seperated list of 
# which field in the <tablename.asc> is associated with which field in the
# form. The pipe seperated list is in the order with which the form fields are
# visited, and the numbers they hold indicate which field in the
# <tablename.asc> file holds the value to be used. eg.
#
# example file:
#
# @ 3
# 2|4|1
#
# The first line indicates that the form has three fields. The second line
# indicates that the first form field's value can be found in the second field
# of the .asc file. The second form field's value can be found in the fourth
# field of the .asc file - the .asc file does not have to have the same number
# of fields as the .cfg file, any excess fields are justr ignored. 
#
##############################################################################

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

   # build the command to run pharaoh in a pipe
   cmd = "AMGR com.al"
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
   printf "\033ca" | cmd
   #system("sleep 1")

   # Cycle through each of the fields and pick out the info to type in
   for (count = 1; count <= total; count++) {
      chopped = chop($form[count])
      if (chopped == "" || chopped ~ /\*+/) { 
         printf "\r" | cmd }
         #system("sleep 1") }
      else {
         printf chopped "\r" | cmd }
         #system("sleep 1") }
   }

   # add the record
   printf "\033au" | cmd
   #system("sleep 1")

}

END {
   # leave pharaoh
   printf "\033pF\033pF" | cmd
   
   # Close the pipe
   close(cmd)
}
