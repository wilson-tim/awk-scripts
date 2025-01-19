###############################################################################
#                                                                             #
# AWK LIBRARY FUNCTIONS VERSION 0.01  (c) William Wragg 2000                  #
# BY WILLIAM WRAGG                                                            #
# DATE 18/08/2000                                                             #
#                                                                             #
# All local varaiables are preceded with an underscore e.g. _local            #
#                                                                             #
#                                                                             #
###############################################################################

# FUNCTION DEFINITIONS - START
# ----------------------------
# This function can retrieve any value from a random sequence, given the seed.
function any_rand(seed, turn,   _count) {
   srand(seed)
   for (_count = 1; _count <= turn; _count++) {
      int(rand() * 255) }
   return int(rand() * 255) }

# This function inserts a string into another string, at a specified position.
function insert(string, pos, ins,   _before_tmp, _after_tmp) {
   _before_tmp = substr(string, 1, pos)
   _after_tmp = substr(string, pos + 1)
   return _before_tmp ins _after_tmp }

# This function pads a string with additional characters, to make the string
# upto a set size.
function pad(string, pad_char, size,   _count, _string_length) {
   _string_length = length(string)
   if (_string_length < size) {
      for (_count = 1; _count <= (size - _string_length); _count++) {
         string = string pad_char } }
   return string }

# This function takes a string and chops it into a number of smaller strings,
# and outputs them as a numbered array. The function creates two global variables
# location_array and location_array_size.
function chop(string, size,    _count, _original_length, _line) {
   _original_length = length(string)
   for (_count = 1; _count < _original_length/size; _count++) {
      string = insert(string, (_count * size + (_count - 1)), "~")
   }
   location_array_size = split(string, location_array, "~")
   for (_line in location_array) {
      location_array[_line] = pad(location_array[_line], " ", size) 
   }
}

# This function creates an empty array.
function carray( _array) {   # Argumnets
   _array[1] = "create"
   darray(_array)
   return
}

# This function deletes all elements from an array.
function darray( array,  _item ) {

   if ( ! is_empty(array) ) {
      for (_item in array) { delete array[_item] }
   }
}

# This function checks whether an array is empty or not. Returns 1 if empty and
# 0 if their is any data.
function is_empty( array, _item ) {

   # If finds any items then array is not blank
   for (_item in array) { return 0 }

   # Array is blank
   return 1
}

# This function chops off leading, and trailing, spaces from a string.
function truncate( string ) {
   sub(/^ +/,"",string)
   sub(/ *$/,"",string)
   return string
}

# FOR UNIX SYSTEMS ONLY:
# Note the use of "\r" during raw mode.  Newlines will not be translated
# into \n\r sequences,  so you have to do that yourself.
# 
# "stty -g" captures the current stty settings in a numerical symbolic
# format that can be used to restore the original settings.  This is
# a better method than "stty cooked" or "stty sane".
# 
# Note also that the arg list in the function definition is longer than
# the arg list when the function is called.  This creates automatic
# variables whose scope is limited to the function.  It is traditional
# to separate "automatic" variables from called parameters by a
# double space.
# 
# Obviously,  the faster the hardware,  the better this works.
# 
# example:
# ans = prompt("Enter Yes[y] or No[n] == > ","^[nyNY]$")
# printf "\nans = %s\n", ans
function prompt(msg, goodchars,  _stty, _dd, _ans, _cooked) {
stty = "stty -g"
stty | getline _cooked
close(stty)
system("stty raw")
_dd = "dd bs=1 count=1 2>/dev/null"
# I'd just suggest using command "dd cbs=1 count=1 conv=unblock 2>/dev/null"
# instead, so that the output has two bytes, the second being "\n".
# I'm afraid that awk may feel unhapy when the last record is not terminated
# by a newline.

printf "%s", msg
do {
   if (_ans) {
      printf "\r\nInvalid Response '%s'\r\n", _ans
      printf "%s", msg
      }
   _dd | getline _ans
   close(_dd)
   } while (_ans !~ goodchars)

system("stty " _cooked)
return(_ans)
}
