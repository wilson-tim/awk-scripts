###############################################################################
#                                                                             #
# Cellular Automata VERSION 0.02                                              #
# (c) William Wragg 2001                                                      #
# BY WILLIAM WRAGG                                                            #
# DATE 27/06/2001                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#     awk ca.awk                                                              #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
# All global variables are composed only of letters, and the first letter is  #
# a capital. If the global variable is composed of two or more words, then    #
# each of these words is capitalised, not just the first one e.g. Global,     #
# GlobalVariable                                                              #
#                                                                             #
###############################################################################

BEGIN { init(1,80,"random")
   print
   print "CA PLAYGROUND"
   print
   printf "dim[1-3] size[n] rule[live/born] generations[n]: " }

# FUNCTION SECTION.
# -----------------
function init(_dim, _size, _init_type,   # Arguments
_count_x, _count_y, _size_x, _size_y, _ran ) {   # Local Variables
   srand()
   if (_dim == 1) {
      _size_x = _size
      for (_count_x = 1; _count_x <= _size_x; _count_x++) {
         if (_init_type == "random") {
            _ran = rand()
            if (_ran >= 0.5) { _ran = 1}
            else {_ran = 0} 
            array[_count_x] = _ran 
         }
      }
   }
   else if (_dim == 2) {
      _size_x = substr(_size, 1, index(_size,",") - 1) 
      _size_y = substr(_size, index(_size,",") + 1) 
      for (_count_y = 1; _count_y <= _size_y; _count_y++) {
         for (_count_x = 1; _count_x <= _size_x; _count_x++) {
            if (_init_type == "random") {
               _ran = rand()
               if (_ran >= 0.5) { _ran = 1}
               else {_ran = 0}
               array[_count_x, _count_y] = _ran
            }
         }
      }
   }
} 

# This function updates a CA array 'array' of dimention '_dim' and size
# '_size' with the rule '_rule'. The '_size' variable is a string with the size
# of the array i.e. 100,200 no spaces.
# The '_rule' variable is a string of the form nnn...n/nnn...n, where
# the first part of the rule is a list of numbers for a live cell to stay alive,
# and the second part is a list of numbers for a dead cell to be born. E.g. 
# John Conways life would be represented by the string '23/3', i.e. if 2 OR 3
# cells are alive around the cell being considered, and the cell being
# considered is alive, then it stays alive, and if their are 3 cells around the
# cell being considered, and the cell being considered is dead, then it is born.
function update(_dim, _size, _rule,   # Arguments
_live, _die, _count_x, _count_y, _size_x, _size_y,   # Local Variables
_array_copy, _total, _xm1, _xp1, _ym1, _yp1) {   # Local Variables
   if (_dim == 1) {
      _live = substr(_rule, 1, index(_rule,"/") - 1)
      _die = substr(_rule, index(_rule,"/") + 1)
      _size_x = _size

      for (item in array) { _array_copy[item] = array[item] }

      for (_count_x = 1; _count_x <= _size_x; _count_x++) {
         # Do the wrap-around (infinite universe)
         if (_count_x == 1) { _xm1 = _size_x; _xp1 = _count_x + 1 }
         else if (_count_x == _size_x) { _xm1 = _count_x - 1; _xp1 = 1 }
         else { _xm1 = _count_x - 1; _xp1 = _count_x + 1 }

         _total = array[_xm1] + array[_xp1]

         if (array[_count_x] == 1) {
            if (index(_live,_total) > 0) {
               _array_copy[_count_x] = 1
            } 
            else { _array_copy[_count_x] = 0 }
         }
         else if (array[_count_x] == 0 ) {
            if (index(_die,_total) > 0) {
               _array_copy[_count_x] = 1 
            }
            else { _array_copy[_count_x] = 0 }
         }
      }
      for (item in _array_copy) { array[item] = _array_copy[item] }
   }
   else if (_dim == 2) {
      _live = substr(_rule, 1, index(_rule,"/") - 1)
      _die = substr(_rule, index(_rule,"/") + 1)
      _size_x = substr(_size, 1, index(_size,",") - 1)
      _size_y = substr(_size, index(_size,",") + 1)

      for (item in array) { _array_copy[item] = array[item] }

      for (_count_y = 1; _count_y <= _size_y; _count_y++) {
         for (_count_x = 1; _count_x <= _size_x; _count_x++) {
            # Do the wrap-around (infinite universe)
            if (_count_x == 1) { _xm1 = _size_x; _xp1 = _count_x + 1 }
            else if (_count_x == _size_x) { _xm1 = _count_x - 1; _xp1 = 1 }
            else { _xm1 = _count_x - 1; _xp1 = _count_x + 1 }

            if (_count_y == 1) { _ym1 = _size_y; _yp1 = _count_y + 1 }
            else if (_count_y == _size_y) { _ym1 = _count_y - 1; _yp1 = 1 }
            else { _ym1 = _count_y - 1; _yp1 = _count_y + 1 }

            _total = array[_xm1,_ym1] + array[_count_x,_ym1] + array[_xp1,_ym1] + array[_xm1,_count_y] + array[_xp1,_count_y] + array[_xm1,_yp1] + array[_count_x,_yp1] + array[_xp1,_yp1]
 
            if (array[_count_x,_count_y] == 1) {
               if (index(_live,_total) > 0) {
                  _array_copy[_count_x,_count_y] = 1
               }
               else { _array_copy[_count_x,_count_y] = 0 }
            }
            else if (array[_count_x,_count_y] == 0 ) {
               if (index(_die,_total) > 0) {
                  _array_copy[_count_x,_count_y] = 1
               }
               else { _array_copy[_count_x,_count_y] = 0 }
            }
         }
         for (item in _array_copy) { array[item] = _array_copy[item] }
      }
   }
}

function show(_dim, _size,   # Arguments
_count_x, _count_y, _size_x, _size_y, _array_print ) {   # Local Variables
   if (_dim == 1) {
      _array_print = ""
      _size_x = _size

      for (_count_x = 1; _count_x <= _size_x; _count_x++) {
         if (array[_count_x] == 0) { _array_print = _array_print "." }
         else if (array[_count_x] == 1) { _array_print = _array_print "o" }
      }
      print _array_print
   }
   if (_dim == 2) {
      _size_x = substr(_size, 1, index(_size,",") - 1)
      _size_y = substr(_size, index(_size,",") + 1)

      for (_count_y = 2; _count_y <= _size_y; _count_y += 2) {
         _array_print = ""
         for (_count_x = 1; _count_x <= _size_x; _count_x++) {
            if (array[_count_x,_count_y - 1] == 1) {
               if (array[_count_x,_count_y] == 0) {
                  _array_print = _array_print "'" 
               }
               else if (array[_count_x,_count_y] == 1) {
                  _array_print = _array_print ":" 
               }
            }
            else {
               if (array[_count_x,_count_y] == 0) {
                  _array_print = _array_print " "
               }
               else if (array[_count_x,_count_y] == 1) {
                  _array_print = _array_print "."
               }
            }
         }
         print _array_print
      }
      for (_count_x = 1; _count_x <= _size_x; _count_x++) { printf "-" }
      print ""
   }
}     
# ------------------------ 
# END OF FUNCTION SECTION.

# PATTERN SECTION.
# ----------------
# dim size rule generations
/1 [0-9]* [0-9]*\/[0-9]* [0-9]*/ || /2 [0-9]*,[0-9]* [0-9]*\/[0-9]* [0-9]*/{
   init($1,$2,"random")
   for (count = 1; count <= $4; count++) {
      show($1,$2)
      update($1,$2,$3)
   }
   printf "dim[1-3] size[n] rule[live/born] generations[n]: "
}
# -----------------------
# END OF PATTERN SECTION.


END {}
