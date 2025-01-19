###############################################################################
#                                                                             #
# DREAMLAND VERSION 0.05  (c) William Wragg 2000                              #
# BY WILLIAM WRAGG                                                            #
# DATE 18/08/2000                                                             #
#                                                                             #
# All local varaiables are preceded with an underscore e.g. _local            #
#                                                                             #
#              ____                           _                 _             #
#             |  _ \ _ __ ___  __ _ _ __ ___ | | __ _ _ __   __| |            #
#             | | | | '__/ _ \/ _` | '_ ` _ \| |/ _` | '_ \ / _` |            #
#             | |_| | | |  __/ (_| | | | | | | | (_| | | | | (_| |            #
#             |____/|_|  \___|\__,_|_| |_| |_|_|\__,_|_| |_|\__,_|            #
#                                                                             #
#                                                                             #
###############################################################################


BEGIN {
   print "               ____                           _                 _"
   print "              |  _ \\ _ __ ___  __ _ _ __ ___ | | __ _ _ __   __| |"
   print "              | | | | '__/ _ \\/ _` | '_ ` _ \\| |/ _` | '_ \\ / _` |"
   print "              | |_| | | |  __/ (_| | | | | | | | (_| | | | | (_| |"
   print "              |____/|_|  \\___|\\__,_|_| |_| |_|_|\\__,_|_| |_|\\__,_|"
   turn = 1
   seed = 1
   direction = 1
}

# FUNCTION DEFINITIONS - START
# ----------------------------
# THE BASIC FUNCTIONS
# This function can retrieve any value from a random sequence, given the seed.
# This sequence is from 0 - 255.
function any_rand(_seed, _turn,   # Arguments
   _count) {   # Local Variables
   srand(_seed)
   for (_count = 1; _count <= _turn; _count++) {
      int(rand() * 255) 
   }
   return int(rand() * 255)
}

# This function inserts a string into another string, at a specified position.
function insert(_string, _pos, _ins,   # Arguments
   _before_tmp, _after_tmp) {   # Local Variables
   _before_tmp = substr(_string, 1, _pos)
   _after_tmp = substr(_string, _pos + 1)
   return _before_tmp _ins _after_tmp 
}

# This function pads a string with additional characters, to make the string
# upto a set size.
function pad(_string, _pad_char, _size,   # Arguments
   _count, _string_length) {   # Local Variables
   _string_length = length(_string)
   if (_string_length < _size) {
      for (_count = 1; _count <= (_size - _string_length); _count++) {
         _string = _string _pad_char
      }
   }
   return _string
}

# This function takes a string and chops it into a number of smaller strings,
# and outputs them as a numbered array into a global variable. Outputs the size
# of this array in another global variable.
function chop(_string, _size,   # Arguments
   _count, _begin_at, _char, _last_space, _line) {   # Local Variables
   _begin_at = 1
   _last_space = _size

   # Main loop - loops through the string in variable length lines.
   for (_line = 1; _line <= 22; _line++ ) {

      # If the line will fit on a single line and there is no more string left
      # then output it and quit.
      if (length(substr(_string, _begin_at)) <= _size) {
         location_array[_line] = pad(substr(_string, _begin_at), " ", _size)
         location_array_size = _line          # The number of lines
         break
      }

      # Secondary loop - Loops through the line to find a spcae at which to
      # break the line.
      for (_count = _begin_at; _count <= _begin_at + (_size - 1); _count++) {
         _char = substr(_string, _count, 1)
         if (_char == " ") {
            _last_space = _count 
         }
      }
      
      # Pads the line with trailing spaces.
      location_array[_line] = pad(substr(_string, _begin_at, _last_space - (_begin_at - 1)), " ", _size)
      _begin_at = _last_space + 1 
      _last_space = _begin_at + (_size - 1)
   }
}

# THE MAIN FUNCTIONS
# This function deals with the screen printing
function screen_print(_string,   # Arguments
   _line) {   # Local Variables
   chop(_string, 73)
   print "  ___________________________________________________________________________  "
   print "||                                                                           ||"

   for (_line = 1; _line <= location_array_size; _line++) {
      print "|| " location_array[_line] " ||" 
   }

   print "||___________________________________________________________________________||" 
}

# This function creates a value to represent the location, given the turn and
# area. This may in future use a fractal equation instead of the rand function.
function location(_area, _turn) {   # Arguments
   return any_rand(_area, _turn)
}

# This function deals with parseing of the input
function parse() {
   $0 = tolower($0)
   if ($0 ~ /(q|quit)/) {
      print "Quitting DREAMLAND ..."
      exit
   }
   else if ($0 ~ /(^f$|forward)/) { 
      if (direction == 1) { turn++ }
      else if (direction == 2) { seed++ }
      else if (direction == 3) { turn-- }
      else if (direction == 4) { seed-- }
   }
   else if ($0 ~ /(^b$|back|backward)/) { 
      if (direction == 1) { turn-- }
      else if (direction == 2) { seed-- }
      else if (direction == 3) { turn++ }
      else if (direction == 4) { seed++ }
      # Rotate 180 degrees around and face other way.
      direction = direction + 2
   }
   else if ($0 ~ /(^r$|right)/) { 
      if (direction == 1) { seed++ }
      else if (direction == 2) { turn-- }
      else if (direction == 3) { seed-- }
      else if (direction == 4) { turn++ }
      # Rotate clockwise.
      direction++
   }
   else if ($0 ~ /(^l$|left)/) { 
      if (direction == 1) { seed-- }
      else if (direction == 2) { turn++ }
      else if (direction == 3) { seed++ }
      else if (direction == 4) { turn-- }
      # Rotate anti-clockwise.
      direction--
   }
   else if ($0 ~ /(^lk$|look)/) {}

   # Make sure that the variables don't go outside their boundaries.
   if (turn < 1) { turn = 1 }
   if (seed < 1) { seed = 1 }
   if (direction > 4) { direction = direction - 4 }
   if (direction < 1) { direction = direction + 4 }
}
# --------------------------
# FUNCTION DEFINITIONS - END

# PATTERN MATCHING - START
# ------------------------
# This allows for test debug code to be used.
tolower($0) ~ /debug/ {
   debug_string = "hello there every body how are you I hope that all is well and that this works as I do not know what is wrong if this does not work, and this may anoy me. But then again it may not, lets just wait and see shall wee, weel I think that we should."

   screen_print(debug_string)
   screen_print("qwerwteyrutitoypylkhjhbgbfvdcdfsdaredscxfzccxvcbcnvmbbjhhfggfffddseawqewwerrettryrueuritioyoypuyoiououkkukjhiuiiuyujyjthjthrfhgfghdgdysdhsbshshjdhdjjrrhhrhfrjhrjhjjjrtjrjtjrtkrktrtrtjhghhgjjfgutjugtjggjtugujtjgjtgktkgktkjgjtjgjtjkgktgktk")
   next 
}

# This section deals with all the users input commands and is always executed.
{
   parse()
   screen_print("turn:" turn " seed:" seed " faceing:" direction " random:" location(seed, turn))
   next
}
# ----------------------
# PATTERN MATCHING - END

END {}
