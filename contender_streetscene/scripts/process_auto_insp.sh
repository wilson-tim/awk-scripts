:
# Little script to process PDA sample creation
# 11-Dec-2003

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin
TERM=vt100
SHELL=ksh
export PATH TERM SHELL

. /usr/universe/bin/envinf
. $FGLDIR/envcomp

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

exec pdainspect
