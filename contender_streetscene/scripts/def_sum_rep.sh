archive=/usr/universe/v7/share/reports/archive
reports=/usr/universe/v7/share/reports

if ! test -d $reports
then
	mkdir $reports
	chmod 777 $reports
fi

if ! test -d $archive
then
	mkdir $archive
	chmod 777 $archive
fi

if test -e $reports/def_sum*.csv
then
	mv $reports/def_sum*.csv $archive
fi

outfile=def_sum_`date +%d%m%y`.csv
fglgo_def_sum_rep ALL 7 $reports/$outfile N Y

mailmsg='Report U:\\reports\\'$outfile' has been created'
mailit F jenny.miller@brent.gov.uk "Default Summary Report" "$mailmsg"
mailit F chatan.popat@brent.gov.uk "Default Summary Report" "$mailmsg"
