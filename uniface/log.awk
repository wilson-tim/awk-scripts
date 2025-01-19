# 041114 Ulrich Merkel
#
# AWK Script processes UNIFACE V6,V7,V8 compile summary = Transcript Window
# standard Texts are suppressed
#
# This script requires GAWK (GNU awk) 

BEGIN {
MACRONAME = "#tx9_9"
MACROVERS = "041114"
print "Start " MACRONAME,MACROVERS
OUTPUT1 = MACRONAME"_$$1.txt"
OUTPUT2 = MACRONAME"_$$2.txt"
OUTPUT3 = MACRONAME"_$$3.txt"
X_OBJECT = ""
}

END {
  print "Stop   " MACRONAME,MACROVERS
}

# Bei Wechsel des Input-Files
FILENAME != OLDFILENAME {
  X_OBJECT = ""
  OLDFILENAME = FILENAME
}

{ # to clean up some nasty characters (\x0A\x00) included by whoever
gsub("\x0A\x00","")
if ($0 == "") next
}

/^Compile / { # a new object is compiled
# active when input-line reads as:
# Compile central message: 'M001           '
NEW_OBJECT($0)                          # process a new object
next                                    # Skip the line
}

/^Phase *[ 1][1234567890]:/ { # Skip progress info
# active when input-line reads as:
# Phase  9:      Save Form
next                                    # Skip the line
}

$2 == "bytes" && (/used for/ || /total memory usage/) { # skip bytes used for ...
# active when input-line reads as:
# nnnnnn bytes used for ....
next                                    # Skip the line
}


# skip warnings and infos of lesser interest

/info: 1206/ || /info: 1207/ { next } # skip these infos
/info: 6921/ { next } # skip these infos
/info: 1110/ { next } # skip these infos
/warning: 1016/                    { next } # skip these
/warning: 1077/ || /warning: 1144/ { next } # skip these
/warning: 1096/ || /warning: 1072/ { next } # skip these
/warning: 1074/ || /warning: 1075/ { next } # skip these
/info: 1134/ , /\./ { next }                # skip include / exclude infos
$1 == "excludes:" , /\./ { next }           # skip include / exclude infos
/warning: 1043/ || /warning: 1076/ { next } # skip these
/warning: 1145/                    { next } # skip these
/warning: 1073/ || /warning: 1065/ { next } # fields not in sequence / may be truncated on output
/error: 1712/ || /error: 1716/ { next }     # syntax errors in transl.tables
/^I\/O function/ || /^DRIVER ERROR/ { next } # open non-existing table

$1 == "warning:" && /cannot be optimized/ { # skip ...cannot be optimized info
# active when input-line reads as:
# warning: 1000 - 6 Field references cannot be optimized; generate ....
next
}

/^No compilation messages/ { # Summary Information; print it
# active when input-line reads as:
# No compilation messages
PRINT_LEVEL_CHAIN(OUTPUT1)                  # Print the proper headings
print >> OUTPUT1
next
}

/^Compilations / { # Summary Information; print it
# active when input-line reads as:
# Compilations 5 out of 5; Messages: [info 0, warning 0, errors 0]
X_OBJECT = ""
print >> OUTPUT1
next
}

$2 ~ /^compiled$/ && $4 ~ /out/ && $5 ~ /of/ { # Summary Info; print it
# active when input-line reads as:
# Forms compiled 6 out of 6;Messages: [info 0, warning 0, errors 0]
# due to  bug in V5, the line may read as:
# Forms compiled 6 out of 6;Messages: [info 0, warning 0, errors 0]Compile ..
X_OBJECT = ""
print >> OUTPUT1
next
}

/^$/ { # blank line
next                                    # Skip the line
}


{ # print the rest
PRINT_LEVEL_CHAIN(OUTPUT1)                  # Print the proper headings
print >> OUTPUT1
}

# here are functions which go with the listings

function NEW_OBJECT(inp_line) { # a new object is encountered
TEMPSTR = substr(inp_line,9)            # skip the "Compile " part
split(TEMPSTR,TEMPARRAY,":")            # split Object class and name
X_OBJECT = TEMPARRAY[1]": "TEMPARRAY[2]
}

function PRINT_LEVEL_CHAIN(x_output) {  # print the header for this object
if (X_OBJECT != "") {
   print "***** " X_OBJECT >> x_output
   X_OBJECT = ""
   }
}