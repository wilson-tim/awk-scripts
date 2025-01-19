: 
# 
# Shell Script used by Contender to export AV data in XML format
# Andy Jones 04/09/2002 ; Phred 26/2/2004
#
# This script will require modification when installed on a customer site.
# Environment settings are all held in the function "set_variables".

set_variables ()
{
	if [ ! "$DBPATH" ]
	then
		export DBPATH=/databases/version6/PDA
	fi

	if [ ! "$EXPORTDIR" ]
	then
		export EXPORTDIR=/databases/v6/PDA/av_export
	fi

	if [ ! "$CCTDIR" ]
	then
		export CCTDIR=/usr/universe/version6/standard
	fi

	if [ ! "$FGLDIR" ]
	then
		export FGLDIR=/usr/fgl2c
	fi

	if [ ! "$INFORMIXDIR" ]
	then
		export INFORMIXDIR=/usr/informix
	fi

	if [ ! "$INFORMIXSERVER" ]
	then
		export INFORMIXSERVER=contenda
	fi

	if [ ! "$FGLDBPATH" ]
	then
		export FGLDBPATH=/usr/universe/version6/standard/4jschema
	fi

	if [ ! "$FGLLDPATH" ]
	then
		export FGLLDPATH=/usr/universe/version6/standard/modules
	fi

	if [ ! "$DBCENTURY" ]
	then
		export DBCENTURY=C
	fi

	if [ ! "$DBDATE" ]
	then
		export DBDATE=DMY4/
	fi

	if [ ! "$DBMONEY" ]
	then
		export DBMONEY=#
	fi

	if [ ! "$DBEDIT" ]
	then
		export DBEDIT=vi
	fi

	if [ ! "$TERMCAP" ]
	then
		export TERMCAP=/usr2/bin/termcap
	fi

	if [ ! "$DBFORMAT" ]
	then
		export DBFORMAT='#:,:.:'
	fi

	if [ ! "$DBPRINT" ]
	then
		export DBPRINT="lp -s"
	fi

	if [ ! "$DBTEMP" ]
	then
		export DBTEMP=/tmp
	fi

	if [ ! "$INFORMIXSERVER" ]
	then
		export INFORMIXSERVER=`uname -a | cut -f2 -d " "`
	fi

	if [ ! "$PATH" ]
	then
		export PATH=$INFORMIXDIR/bin:$FGLDIR/bin:/usr/bin:$HOME/bin:$PATH
	fi
}

# Check that all informix variables are set
set_variables 

# run the av_export program
sql av_export.sql
sleep 5
cd $CCTDIR/SCRIPTS
cat av_export.csv | sed -f s5.sed | awk -f av_export.awk > av_export.xml
rm -f av_export.csv
