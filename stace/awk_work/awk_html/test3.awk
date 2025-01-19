BEGIN {
   cmd = "c:/progra~1/netscape/commun~1/program/netscape"
   print "" | cmd
}

{ print $0 | cmd }

END {
   close(cmd)
}