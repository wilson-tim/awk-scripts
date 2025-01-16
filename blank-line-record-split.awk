# 250116  TW  New script to split records based on blank lines

# https://www.gnu.org/software/gawk/manual/html_node/awk-split-records.html#:~:text=The%20empty%20string%20%22%22%20(a,Line%20Records%20for%20more%20details.

# $ awk -f blank-line-record-split.awk blank-line-record-split.txt

BEGIN {
	RS="";
	ORS="\r\n";
	OFS="|";
}

$1=$1 {
#	print NF, $0;
	print $0;
}
