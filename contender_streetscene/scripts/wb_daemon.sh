# setup the variables needed to run sql against the specified database.
INFORMIXDIR=/usr/informix
INFORMIXSERVER=odin
CCTDIR=/usr/universe/v7/standard
FGLDIR=/usr/fgl2c
CONTENDERBIN=/usr/universe/bin
export INFORMIXDIR INFORMIXSERVER CONTENDERBIN FGLDIR CCTDIR
. $FGLDIR/envcomp

# Check for the existance of the wb.lock file, this prevents more than one 
# occurance of the daemon from running at a time.
if [ -d /tmp/wb.lock ]
then
	echo "Locked!"
else
	mkdir /tmp/wb.lok

        # The three lines below should exist for each database which the
        # whiteboard daemon needs to be run against.
        DBPATH=/usr/universe/v7/databases/CAMDEN
        export DBPATH
	$CCTDIR/runners/fglgo_wb_daemon debug

	rmdir /tmp/wb.lok
fi
