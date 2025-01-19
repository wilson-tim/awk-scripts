###############################################################################
#                                                                             #
# DREAMLAND VERSION 0.01  (c) William Wragg 2000                              #
# BY WILLIAM WRAGG                                                            #
# DATE 18/08/2000                                                             #
#                                                                             #
# All local varaiables are preceded with an underscore e.g. _local            #
#                                                                             #
#                                                                             #
###############################################################################

BEGIN {
   turn = 1 }

# FUNCTION DEFINITIONS - START
# ----------------------------
# THE BASIC FUNCTIONS
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

# THE MAIN FUNCTIONS
# This function deals with the screen printing
function screen_print(_string,   _line) {
   chop(_string, 73)
   print "  ___________________________________________________________________________  "
   print "||                                                                           ||"
   for (_line = 1; _line <= location_array_size; _line++) {
      print "|| " location_array[_line] " ||" }
   print "||___________________________________________________________________________||" }


# This function deals with parseing of the input
function parse() {
   if (tolower($0) ~ /(f|forward)/) { 
      turn++ }
   else if (tolower($0) ~ /(b|back|backward)/) { 
      if (turn > 1) { turn-- } }
   else if (tolower($0) ~ /(l|lk|look)/) {}
   else if (tolower($0) ~ /(q|quit)/) {
      print "Quitting DREAMLAND ..."
      exit } }

# This function creates a value to represent the location, given the turn and
# area. This may in future use a fractal equation instead of the rand function.
function location(_area, _turn) {
   return any_rand(_area, _turn) }
# --------------------------
# FUNCTION DEFINITIONS - END

# PATTERN MATCHING - START
# ------------------------
# This allows for test debug code to be used.
tolower($0) ~ /debug/ {
   debug_string = "hello there every body how are you I hope that all is well and that this works as I do not know what is wrong if this does not work, and this may anoy me. But then again it may not, lets just wait and see shall wee, weel I think that we should."

   screen_print(debug_string)
   next }

# This section deals with all the users input commands and is always executed.
{
   parse()
   screen_print("turn:" turn " random:" location(1, turn))
   next }
# ----------------------
# PATTERN MATCHING - END

END {}
