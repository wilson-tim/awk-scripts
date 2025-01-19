BEGIN {
   clear()
}


# FUNCTION SECTION
function point(_x, _y, _char) {
   screen[_x,_y]=_char
}

function connection(_x1, _y1, _x2, _y2) {
}

function fill(_x1, _y1, _x2, _y2, _x3, _y3) {}

function clear(   _x, _y) {
   for (_y = 1; _y <= 24; _y++) {
      for (_x = 1; _x <= 80; _x++) {
         screen[_x,_y]=" "
      }
   }
}

function show(   _x, _y) {
   for (_y = 1; _y <= 24; _y++) {
      for (_x = 1; _x <= 80; _x++) {
         printf screen[_x,_y]
      }
      print ""
   }
}


# PATTERN SECTION
{}


END {}
