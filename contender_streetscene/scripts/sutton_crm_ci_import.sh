:
#
# Shell Script used by contender to export CRM enquiries.
# Andy Jones 29/03/2005
#
# This script will require modification when installed on a customer site.
# Environment settings are all held in the function "set_variables".
date
export INFORIXDIR=/usr/informixv7.24
. /usr/fgl2c.v35/envcomp
export FGLGUI=0
export DBPATH=/usr/universe/v7/databases/SUTTON
export IMPORTDIR=/usr/universe/v7/share/imports/CRM/SUTTON
export CCTDIR=/usr/universe/v7/standard
export INFORMIXSERVER=atlas
export FGLDBPATH=$CCTDIR/4jschema
export FGLLDPATH=$CCTDIR/modules
export DBCENTURY=C
export DBDATE=DMY4/
export DBMONEY=#
export DBEDIT=vi
export TERMCAP=/usr/universe/bin/termcap
export DBFORMAT='#:,:.:'
export DBPRINT="lp -s"
export DBTEMP=/usr/universe/v7/DBTEMP
export PATH=/usr/universe/v7/bin:/usr/universe/v7/standard/bin:/usr/universe/v7/bespoke/runners:/usr/universe/v7/standard/runners:/usr/universe/v7/standard/SCRIPTS:/usr/fgl2c/bin:/usr/informixv7.24/bin:/usr/universe/v7/bin:/usr/universe/v7/standard/bin:/usr/universe/v7/bespoke/runners:/usr/universe/v7/standard/runners:/usr/universe/v7/standard/SCRIPTS:/usr/fgl2c/bin:/bin:/usr/bin:/usr/local/bin:/usr/universe/bin:.:/usr/informixv7.24/bin:/usr/universe/bin

for crmfile in `ls $IMPORTDIR/*xml`
do
	echo $crmfile
	cd $CCTDIR/CRM
# ###########################################################################
# THE FINAL ARGUMENT IN THE LINE BELOW IS THE CRM INTERFACE REFERENCE AND MAY
# NEED CUSTOMISING FOR EACH INSTALLATION
# ###########################################################################
	fglrun crm_ci_import debug $crmfile 1
	mv $crmfile $IMPORTDIR/archive
done
