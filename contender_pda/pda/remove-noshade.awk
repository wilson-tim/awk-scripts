# usage:
# gawk -f remove-noshade.awk destdir="#DESTDIR#" #FILENAME#
#
# Eg.
# gawk -f remove-noshade.awk destdir="#DESTDIR#" #FILENAME#
#

BEGIN {

}

/noshade="noshade"/ {
    gsub(/noshade="noshade"/,"",$0)
}

/noshade/ {
    gsub(/noshade/,"",$0)
}

dir = destdir
{ if (index(dir, "\\") == 0) {
    dir = dir "\\"
  }
}

{ print $0 >> dir FILENAME }

END {

  close(dir FILENAME)

}
