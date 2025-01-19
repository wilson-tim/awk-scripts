: 
# 
# Shell Script used by contender to export CRM customers in XML format
# Andy Jones 04/09/2002
#
# This script will require modification when installed on a customer site.
# Environment settings are all held in the function "set_variables".

set_variables ()
{
	if [ ! "$DBPATH" ]
	then
		export DBPATH=/databases/version6/CRM
	fi

	if [ ! "$IMPORTDIR" ]
	then
		export IMPORTDIR=/databases/v6/CRM/crm_import
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
		export INFORMIXSERVER=startrek
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
		export DBTEMP=/usr4/INFORMIX_TEMP
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

# run the crm_export program
for crmfile in `ls $IMPORTDIR/*xml`
do
	echo $crmfile
	sleep 1
	cd $CCTDIR/SCRIPTS
	./xml2psv `echo $crmfile | sed "s/\.xml//g"`
	unloadfile=`echo $crmfile | sed "s/\.xml/\.unl/g"`
	cat `echo $crmfile |sed "s/\.xml/\.psv/g"`|sed "s/\|\|$/\|/g" > $unloadfile
	cd $CCTDIR/CRM
	fglrun crm_import $unloadfile
done
