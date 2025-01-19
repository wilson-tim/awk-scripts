# 
# Shell Script used by contender to import GIS Streets & Properties   
# Andy Jones 04/09/2002
#

set_variables ()
{
	if [ ! "$DBPATH" ]
	then
		DBPATH=/startrek/databases/version6/BRENT
		export DBPATH
	fi

	if [ ! "$GISIMPORTDIR" ]
	then
		GISIMPORTDIR=/startrek/databases/v6/BRENT/gis_import
		export GISIMPORTDIR
	fi

	if [ ! "$CCTDIR" ]
	then
		CCTDIR=/startrek/usr/universe/version6/standard
		export CCTDIR
	fi

	if [ ! "$FGLDIR" ]
	then
		FGLDIR=/usr/fgl2c
		export FGLDIR
	fi

	if [ ! "$INFORMIXDIR" ]
	then
		INFORMIXDIR=/startrek/usr/informix
		export INFORMIXDIR
	fi

	if [ ! "$INFORMIXSERVER" ]
	then
		INFORMIXSERVER=scodev
		export INFORMIXSERVER
	fi

	if [ ! "$FGLDBPATH" ]
	then
		FGLDBPATH=/startrek/usr/universe/version6/standard/4jschema
		export FGLDBPATHa
	fi

	if [ ! "$FGLLDPATH" ]
	then
		FGLLDPATH=/startrek/usr/universe/version6/standard/modules
		export FGLLDPATH
	fi

	if [ ! "$DBCENTURY" ]
	then
		DBCENTURY=C
		export DBCENTURY
	fi

	if [ ! "$DBDATE" ]
	then
		DBDATE=DMY4/
		export DBDATE
	fi

	if [ ! "$DBMONEY" ]
	then
		DBMONEY=#
		export DBMONEY
	fi

	if [ ! "$DBEDIT" ]
	then
		DBEDIT=vi
		xport DBEDIT
	fi

	if [ ! "$TERMCAP" ]
	then
		TERMCAP=/startrek/usr2/bin/termcap
		export TERMCAP
	fi

	if [ ! "$DBFORMAT" ]
	then
		DBFORMAT='#:,:.:'
		export DBFORMAT
	fi

	if [ ! "$DBPRINT" ]
	then
		DBPRINT="lp -s"
		export DBPRINT
	fi

	if [ ! "$DBTEMP" ]
	then
		DBTEMP=/startrek/usr4/INFORMIX_TEMP
		export DBTEMP
	fi

	if [ ! "$INFORMIXSERVER" ]
	then
		INFORMIXSERVER=`uname -a | cut -f2 -d " "`
		export INFORMIXSERVER
	fi

	if [ ! "$PATH" ]
	then
		PATH=$INFORMIXDIR/bin:$FGLDIR/bin:/startrek/usr/bin:$HOME/bin:$PATH
		export PATH
	fi
}

# Check that all informix variables are set

set_variables 

# run the gis_import program

cd $CCTDIR/SCRIPTS

for gisfile in `ls $GISIMPORTDIR/gis_street*[0-9]`
do
        cd $CCTDIR/SCRIPTS
        awk -f gis.awk "$gisfile" > "$gisfile".unl
        mv "$gisfile".unl "$gisfile" 
done

for gisfile in `ls $GISIMPORTDIR/gis_data*[0-9]`
do
        cd $CCTDIR/SCRIPTS
        awk -f gis.awk "$gisfile" > "$gisfile".unl
        mv "$gisfile".unl "$gisfile" 
done
