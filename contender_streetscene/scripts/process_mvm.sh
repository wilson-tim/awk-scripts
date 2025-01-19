: 
# 
# Shell script used by contender to import MVM records
# Andy Jones 23/03/2005
#
# This script will require modification when installed on a customer site.
# Environment settings are all held in the function "set_variables".

set_variables ()
{
	if [ ! "$FGLDIR" ]
	then
		export FGLDIR=/usr/fgl2c
	fi

	if [ ! "$INFORMIXDIR" ]
	then
		export INFORMIXDIR=/usr/informix
	fi

	if [ ! "$DBPATH" ]
	then
		export DBPATH=/usr/universe/v7/databases/trainer
	fi

	if [ ! "$CCTDIR" ]
	then
		export CCTDIR=/usr/universe/v7/standard
	fi

	if [ ! "$IMPORTDIR" ]
	then
		export IMPORTDIR=/tmp
	fi

	if [ ! "$FGLDBPATH" ]
	then
		export FGLDBPATH=$CCTDIR/4jschema
	fi

	if [ ! "$FGLLDPATH" ]
	then
		export FGLLDPATH=$CCTDIR/modules
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
		export TERMCAP=/usr/universe/bin/termcap
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
		export DBTEMP=/usr/universe/v7/DBTEMP
	fi

	if [ ! "$INFORMIXSERVER" ]
	then
		export INFORMIXSERVER=`uname -a | cut -f2 -d " "`
	fi

	if [ ! "$PATH" ]
	then
		export PATH=$CCTDIR/runners:$INFORMIXDIR/bin:$FGLDIR/bin:/usr/universe/bin:$PATH
	fi
}

# Check that all informix variables are set
set_variables 

fglgo_nlpg11_locn mvm debug
fglgo_nlpg24_site mvm debug
fglgo_nlpg21_site_detail mvm debug
