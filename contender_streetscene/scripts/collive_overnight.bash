
# Contender Overnight Script
# modified version for bash for windows using cygwin - 7/2/06 - Phred
################################################################################
## Set up the environment #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
#  First parameter specifies environment - defaults to live if none given
################################################################################

echo overnight $*

ENV=${1-live}

ROOTDIR=D:/DES/contender/version7
CYGROOT=D:/DES/CONTENDER/version7
FGLDIR=D:\\DES\\CONTENDER\\version7\\FourJs\\f4gl
FGLPROFILE=$FGLDIR/etc/fglprofile.$ENV
LOGDIR=$ROOTDIR/LOGFILES/$ENV
LOGFILE=$LOGDIR/overnight.log
MAILFILE=$ROOTDIR/bin/overnight.mail
TERM=ansi
SHELL=bash
CCTDIR=$ROOTDIR/standard
PATH=$PATH:$ROOTDIR/bin:$ROOTDIR/runners
DBPATH=$CCTDIR/modules:$CONTENDER_HOME/Databases/$ENV
DBBASE=$DBPATH:$CCTDIR:$CCTDIR/LOOKUPS:$CCTDIR/UTILS 
FGLGUI=0
FGLRUN=$FGLDIR/bin/fglrundyn
FGLLDPATH=$CCTDIR/modules

export ROOTDIR CYGROOT FGLDIR FGLPROFILE PATH LOGDIR LOGFILE MAILFILE
export TERM SHELL CCTDIR DBPATH DBBASE FGLGUI FGLRUN FGLLDPATH ENV

################################################################################
## GENERAL TIDY-UP #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
################################################################################

# Do not remove spool files, $ROOTDIR/bin/mspool sorts out at 23:55
# rm -r $ROOTDIR/spool/$ENV
# mkdir $ROOTDIR/spool/$ENV
# chmod 777 $ROOTDIR/spool/$ENV

################################################################################
## V7 LIVE DATABASE *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
################################################################################

echo "Overnight started `date`" > $MAILFILE
#set  >> $MAILFILE

## bcheck and update statistics: CHECK AND FIX THE DATABASE
#  Doesn't happen on SQL

## UPSII2 : Update si_i.date_due for scheduled tasks 
#echo "Updating Live Site Items `date`" >> $MAILFILE
#cd $CCTDIR/UPDTE_SI_I
#$FGLRUN upsii2 >> $MAILFILE

## LLPG : Process any waiting LLPG updates
echo "Processing LLPG `date`" >> $MAILFILE
bash $CCTDIR/SCRIPTS/process_llpg.bash

## BLPU : Process any waiting BLPU updates
echo "Processing BLPU `date`" >> $MAILFILE
bash $CCTDIR/SCRIPTS/process_blpu.bash

## Update the contender site friendly address
echo "Processing gis_site12 `date`" >> $MAILFILE
cd $CCTDIR/GIS_UTILS
$FGLRUN gis_site12 >> $MAILFILE

## Update the trade site friendly address
echo "Processing trade_addresses `date`" >> $MAILFILE
cd $CCTDIR/GIS_UTILS
$FGLRUN trade_addresses >> $MAILFILE

## Update the trade site friendly address
echo "Processing trade contract values `date`" >> $MAILFILE
cd $CCTDIR/TRADE
$FGLRUN value_agree >> $MAILFILE

## PDA Processing...
#echo "Processing auto insp `date`" >> $MAILFILE
#bash $CCTDIR/SCRIPTS/camden_process_auto_insp.bash >> /dev/null

################################################################################
# End
################################################################################

echo "Overnight finished `date`" >> $MAILFILE
cat $MAILFILE >> $LOGFILE
mailit F fiona@datapro.co.uk "City of London Overnight `date`" $MAILFILE
#mailit F bob@datapro.co.uk "Camden Overnight `date`" $MAILFILE
