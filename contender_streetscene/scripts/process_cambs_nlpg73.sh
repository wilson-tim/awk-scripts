:
# Script to process NLPG updates in varying formats - specific to Cambs.

# set_variables

PATH=$PATH:/usr/universe/bin:/usr/informix/bin
TERM=vt100
SHELL=ksh
export PATH TERM SHELL

INFORMIXDIR=/usr/informix
INFORMIXSERVER=cambrid
EDITOR=vi
DBMONEY=£
DBDATE=DMY4/
DBTEMP=/usr/universe/v8/DBTEMP/live
FGLDIR=/usr/fgl2c.flm
CCTDIR=/usr/universe/v8/standard
export INFORMIXDIR INFORMIXSERVER EDITOR DBMONEY DBTEMP FGLDIR CCTDIR DBDATE

. $FGLDIR/envcomp

FGLLDPATH=/usr/universe/v8/standard/modules
export FGLLDPATH

FGLGUI=0
export FGLGUI

DBPATH=/usr/universe/v7/databases/live
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS:$CCTDIR/modules
export DBPATH DBBASE

PATH=$PATH:$CCTDIR/runners:$CCTDIR/modules
export PATH

importdir=/usr/NLPG
importlog=$importdir/nlpg_import_`date | awk '{print $3"-"$2"-"$6}'`.log

# Process any waiting files

for importfile in `ls $importdir/05*csv`
do
        echo $importfile >> $importlog
        fglgo_nlpg73_main debug $importfile >> $importlog
        mv $importfile $importdir/archive73
done

# Email the logfile
if [ -f $importlog ]
then
        mailit F david.hopkins@cambridge.gov.uk "NLPG 7.3 Imports `date`" $importlog
#       mailit F bernard.gravett@btinternet.com "NLPG 7.3 Imports `date`" $importlog
fi
