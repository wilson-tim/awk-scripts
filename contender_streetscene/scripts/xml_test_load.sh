: 
# 
# Program used by contender to convert and process web sent XML files 
# Andy Jones 04/04/2002
#

set -x
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
	cnt=`grep -c 'Abandoned Vehicle' $xml_file`
	if [ $cnt -gt 0 ]
	then
#		xml2psv `echo $xml_file | sed "s/\.xml//g"`
		echo "$xml_file: Abandoned Vehicle"
		fglgo_ci_upload `echo $xml_file | sed "s/\.xml/\.psv/g"` A
	fi
	cnt=`grep -c '\>Refuse Collection service request\<' $xml_file`
	if [ $cnt -gt 0 ]
	then
#		xml2psv `echo $xml_file | sed "s/\.xml//g"`
		echo "$xml_file: Refuse Collection service request"
		fglgo_ci_upload `echo $xml_file | sed "s/\.xml/\.psv/g"` R
	fi
	cnt=`grep -c 'Special Collection request' $xml_file`
	if [ $cnt -gt 0 ]
	then
#		xml2psv `echo $xml_file | sed "s/\.xml//g"`
		echo "$xml_file: Special Collection request"
		fglgo_ci_upload `echo $xml_file | sed "s/\.xml/\.psv/g"` S
	fi
	cnt=`grep -c 'Street Cleaning Request' $xml_file`
	if [ $cnt -gt 0 ]
	then
#		xml2psv `echo $xml_file | sed "s/\.xml//g"`
		echo "$xml_file: Street Cleaning Request"
		fglgo_ci_upload `echo $xml_file | sed "s/\.xml/\.psv/g"` E
	fi
done
