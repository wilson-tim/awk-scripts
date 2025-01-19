:
#
# Shell Script used by contender to import CRM enquiries in xml format.
#

PATH=$PATH:/usr/universe/bin:/usr/informix/bin
TERM=vt100
SHELL=ksh

export PATH TERM SHELL

INFORMIXDIR=/usr/informix
INFORMIXSERVER=cambrid
EDITOR=vi
DBMONEY=£
DBDATE=DMY4/
DBTEMP=/usr/universe/v7/DBTEMP/live
FGLDIR=/usr/fgl2c
CCTDIR=/usr/universe/v7/standard
export INFORMIXDIR INFORMIXSERVER EDITOR DBMONEY DBTEMP FGLDIR CCTDIR DBDATE

. $FGLDIR/envcomp

FGLLDPATH=/usr/universe/v7/standard/modules
export FGLLDPATH

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners
export PATH

importdir=/usr/universe/v7/share/imports/CRM
importlog=/usr/universe/v7/share/imports/CRM/crm_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for crmfile in `ls $importdir/*.xml | sort`
do
	echo $crmfile >> $importlog
	cd $CCTDIR/CRM
	fglrun crm_ci_import debug $crmfile >> $importlog
	mv $crmfile $importdir/archive
done

# Email the logfile

if [ -f $importlog ]
then
	mailit F david.hopkins@cambridge.gov.uk "CRM Imports `date`" $importlog
	mailit F bernard.gravett@btinternet.com "CRM Imports `date`" $importlog
fi
