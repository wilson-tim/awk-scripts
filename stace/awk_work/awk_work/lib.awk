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
function any_rand(_seed, _turn,   _count) {
   srand(_seed)
   for (_count = 1; _count <= _turn; _count++) {
      int(rand() * 255) }
   return int(rand() * 255) }

# This function inserts a string into another string, at a specified position.
function insert(_string, _pos, _ins,   _before_tmp, _after_tmp) {
   _before_tmp = substr(_string, 1, _pos)
   _after_tmp = substr(_string, _pos + 1)
   return _before_tmp _ins _after_tmp }

# This function pads a string with additional characters, to make the string
# upto a set size.
function pad(_string, _pad_char, _size,   _count, _string_length) {
   _string_length = length(_string)
   if (_string_length < _size) {
      for (_count = 1; _count <= (_size - _string_length); _count++) {
         _string = _string _pad_char } }
   return _string }

# This function takes a string and chops it into a number of smaller strings,
# and outputs them as a numbered array.
function chop(_string, _size,    _count, _original_length, _line) {
   _original_length = length(_string)
   for (_count = 1; _count < _original_length/_size; _count++) {
      _string = insert(_string, (_count * _size + (_count - 1)), "~") }
   location_array_size = split(_string, location_array, "~")
   for (_line in location_array) {
      location_array[_line] = pad(location_array[_line], " ", _size) } }

# This function creates an empty array.
function carray( _array) {   # Argumnets
   _array[1] = "create"
   darray(_array)
   return
}

# This function deletes all elements from an array.
function darray( _array,   # Arguments
   _item ) {   # Local variables

   if ( ! is_empty(_array) ) {
      for (_item in _array) { delete _array[_item] }
   }
}

# This function checks whether an array is empty or not. Returns 1 if empty and
# 0 if their is any data.
function is_empty( _array,   # Arguments
   _item ) {   # Local variables

   # If finds any items then array is not blank
   for (_item in _array) { return 0 }

   # Array is blank
   return 1
}

# This function chops off leading, and trailing, spaces from a string.
function truncate( _string ) {   # Arguments
   sub(/^ +/,"",_string)
   sub(/ *$/,"",_string)
   return _string
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
function prompt(_msg, _goodchars,   # Arguments
   _stty, _dd, _ans, _cooked) {   # Local variables
stty = "stty -g"
stty | getline _cooked
close(stty)
system("stty raw")
_dd = "dd bs=1 count=1 2>/dev/null"
# I'd just suggest using command "dd cbs=1 count=1 conv=unblock 2>/dev/null"
# instead, so that the output has two bytes, the second being "\n".
# I'm afraid that awk may feel unhapy when the last record is not terminated
# by a newline.

printf "%s", _msg
do {
   if (_ans) {
      printf "\r\nInvalid Response '%s'\r\n", _ans
      printf "%s", _msg
      }
   _dd | getline _ans
   close(_dd)
   } while (_ans !~ _goodchars)

system("stty " _cooked)
return(_ans)
}
