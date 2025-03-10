###############################################################################
#                                                                             #
# VIEW-CHANGES VERSION 0.01  (c) William Wragg 2000                           #
# BY WILLIAM WRAGG                                                            #
# DATE 15/09/2000                                                             #
#                                                                             #
# All local varaiables are preceded with an underscore e.g. _local            #
#                                                                             #
#                                                                             #
###############################################################################

BEGIN {
   line1 = line2 = line3 = ""
   print "###############################################################################"
   print "#                                                                             #"
   print "# VIEW-CHANGES VERSION 0.01  (c) William Wragg 2000                           #"
   print "# BY WILLIAM WRAGG                                                            #"
   print "#                                                                             #"
   print "###############################################################################"
   print "q=quit, all=prints all records, find <criteria>=search with regular expressions"
   printf("main> ")}
 

# FUNCTION DEFINITIONS - START
# ----------------------------
# THE BASIC FUNCTIONS
# This function pads a string with additional characters, to make the string
# upto a set size.
function pad(_string, _pad_char, _size,   _count, _string_length) {
   _string_length = length(_string)
   if (_string_length < _size) {
      for (_count = 1; _count <= (_size - _string_length); _count++) {
         _string = _string _pad_char } }
   return _string }


# This function takes a string and chops it into a number of smaller strings,
# and outputs them as a numbered array into a global variable. Outputs the size
# of this array in another global variable.
function chop(_string, _size,    _count, _begin_at, _char, _last_space, _line) {
   _begin_at = 1
   _last_space = _size

   # Main loop - loops through the string in variable length lines.
   for (_line = 1; _line <= 22; _line++ ) {

      # If the line will fit on a single line and there is no more string left
      # then output it and quit.
      if (length(substr(_string, _begin_at)) <= _size) {
         location_array[_line] = pad(substr(_string, _begin_at), " ", _size)
         location_array_size = _line          # The number of lines
         break }

      # Secondary loop - Loops through the line to find a spcae at which to
      # break the line, if no spaces then the whole line is output.
      for (_count = _begin_at; _count <= _begin_at + (_size - 1); _count++) {
         _char = substr(_string, _count, 1)
         if (_char == " ") {
            _last_space = _count } }
      
      # Pads the line with trailing spaces.
      location_array[_line] = pad(substr(_string, _begin_at, _last_space - (_begin_at - 1)), " ", _size)
      _begin_at = _last_space + 1 
      _last_space = _begin_at + (_size - 1) } }


# THE MAIN FUNCTIONS
# This function deals with the screen printing
function screen_print(_string,   _line) {
   chop(_string, 73)
   print " |___________________________________________________________________________| "
   print "||                                                                           ||"
   for (_line = 1; _line <= location_array_size; _line++) {
      print "|| " location_array[_line] " ||" }
   print "||___________________________________________________________________________||" }
# --------------------------
# FUNCTION DEFINITIONS - END


# PATTERN MATCHING - START
# ------------------------
# Print the top level prompt
$0 !~ /all|find|q/{
   printf("main> ") }


# This quits the program
$1 == "q" {
   print "Quitting ..."
   exit }


# Print all the records
$1 == "all" {
   # Blank the tree record lines
   line1 = line2 = line3 = ""
 
   # Get each line from the changes.dat file
   while ( (getline < "changes.dat") > 0) {
      # If this is first line of a record save it
      if ($4 == "-" && $8 == "-") {
         line1 = $0 }
      # If this is the second line of the record save it
      else if ($0 ~ /NEW/) {
         line2 = $0 }
      # If this is the third line of the record or the second line if there
      # wasn't an actual record second line
      else if ($0 != "" && (line1 != "" || line2 != "")) {
         line3 = $0 }
      # If this is a record separator (a blank line) then print out the
      # complete record
      else if ($0 == "" && line3 != "") {
         print "  ___________________________________________________________________________  "
         gsub(/-/, "|", line1)
         print " | " pad(line1, " ", 73) " | "
         screen_print(line2 " " line3)
         line1 = line2 = line3 = "" } }
   
   # Close the changes.dat file
   close("changes.dat")
   next }


# This section allows the user to type in search criteria in awk regular
# expression. Each matching record is shown, one at a time. The user must
# press the return key for the next record, or 'q' to quit back to the main
# program.
$1 == "find" {
   # Initialise the varaibles, $2 is the search criteria entered by the user
   line1 = line2 = line3 = ""
   search_criteria = $2 
   ok_to_print = "false"

   # Get each line from the changes.dat file
   while ( (getline < "changes.dat") > 0) {
      # Check to see if this line matches the search criteria, if it does set
      # a flag to tell the print section to print this entire record.
      if ($0 ~ search_criteria) {
         ok_to_print = "true" }

      # If this is first line of a record save it
      if ($4 == "-" && $8 == "-") {
         line1 = $0 }
      # If this is the second line of the record save it
      else if ($0 ~ /NEW/) {
         line2 = $0 }
      # If this is the third line of the record or the second line if there
      # wasn't an actual record second line
      else if ($0 != "" && (line1 != "" || line2 != "")) {
         line3 = $0 }
      # If this is a record separator (a blank line) then print out the
      # complete record only if the search criteria were found somewhere in
      # this record
      else if ($0 == "" && line3 != "") {
         if (ok_to_print == "true") {
            print "  ___________________________________________________________________________  "
            gsub(/-/, "|", line1)
            print " | " pad(line1, " ", 73) " | "
            screen_print(line2 " " line3) 
            # Print the finding prompt
            printf("find> ")
            # Wait for user input, any key except 'q' will get the next record
            getline user_input 
            if (user_input == "q") {
               print "New search ..."
               break } }

         # Do even if the search criteria didn't match
         line1 = line2 = line3 = ""
         ok_to_print = "false" } }

   # Close the changes.dat file
   close("changes.dat")
   next }
# ----------------------
# PATTERN MATCHING - END


END {}
