: 
# 
# Program used by contender to convert and process web sent XML files 
# Andy Jones 04/04/2002
#

#set -x
xmlpath=$1
archive=$2
if test $xmlpath
then
	xmlpath=$xmlpath"/"
else
	xmlpath=`pwd`"/"
fi
if ! test $archive
then
	archive=/tmp
fi
if ! test -r $xmlpath*.xml
then
	echo "No XML files found in the specified directory"
	exit
fi

for xml_file in `ls $xmlpath*.xml`
do
	cat $xml_file |\
	sed -e "s///g" |\
	sed -e "/^$/d" > $xml_file.mod
	mv $xml_file.mod $xml_file

	cnt=`grep -c '\|Abandoned Vehicle' $xml_file`
	if [ $cnt -gt 0 ]
	then
		grep '\|Abandoned Vehicle' $xml_file > $xml_file.avfile
		fglgo_ci_split $xmlpath $xml_file.avfile A
		for av_file in `ls $xmlpath*.av`
		do
			echo "$av_file: Abandoned Vehicle"
			cp $av_file `echo $av_file | sed "s/\.av/\.psv/g"`
			fglgo_ci_upload `echo $av_file | sed "s/\.av/\.psv/g"` A
			mv $av_file $archive
		done
		mv $xml_file.avfile $archive
		mv $xmlpath*psv $archive
	fi
	cnt=`grep -c '\|Refuse Collection service request' $xml_file`
	if [ $cnt -gt 0 ]
	then
		grep '\|Refuse Collection service request' $xml_file > $xml_file.rcfile
		fglgo_ci_split $xmlpath $xml_file.rcfile R
		for rc_file in `ls $xmlpath*.rc`
		do
			echo "$rc_file: Refuse Collection service request"
			cp $rc_file `echo $rc_file | sed "s/\.rc/\.psv/g"`
			fglgo_ci_upload `echo $rc_file | sed "s/\.rc/\.psv/g"` R
			mv $rc_file $archive
		done
		mv $xml_file.rcfile $archive
		mv $xmlpath*psv $archive
	fi
	cnt=`grep -c '\|Special Collection request' $xml_file`
	if [ $cnt -gt 0 ]
	then
		grep '\|Special Collection request' $xml_file > $xml_file.bwfile
		fglgo_ci_split $xmlpath $xml_file.bwfile S
		for bw_file in `ls $xmlpath*.bw`
		do
			echo "$bw_file: Special Collection request"
			cp $bw_file `echo $bw_file | sed "s/\.bw/\.psv/g"`
			fglgo_ci_upload `echo $bw_file | sed "s/\.bw/\.psv/g"` S
			mv $bw_file $archive
		done
		mv $xml_file.bwfile $archive
		mv $xmlpath*psv $archive
	fi
	cnt=`grep -c '\|Street Cleaning Request' $xml_file`
	if [ $cnt -gt 0 ]
	then
		grep '\|Street Cleaning Request' $xml_file > $xml_file.stfile
		fglgo_ci_split $xmlpath $xml_file.stfile E
		for st_file in `ls $xmlpath*.st`
		do
			echo "$st_file: Street Cleaning Request"
			cp $st_file `echo $st_file | sed "s/\.st/\.psv/g"`
			fglgo_ci_upload `echo $st_file | sed "s/\.st/\.psv/g"` E
			mv $st_file $archive
		done
		mv $xml_file.stfile $archive
		mv $xmlpath*psv $archive
	fi
	mv $xml_file $archive
done
