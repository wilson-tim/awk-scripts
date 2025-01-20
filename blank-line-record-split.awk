# 250116  TW  New script to split records based on blank lines

# https://www.gnu.org/software/gawk/manual/html_node/awk-split-records.html#:~:text=The%20empty%20string%20%22%22%20(a,Line%20Records%20for%20more%20details.

# $ awk -f blank-line-record-split.awk blank-line-record-split.txt

BEGIN {
	RS="";
}

{
#	print NF, $0;
	delim_count = gsub(/\n/, "|");
	suffix_count = 8 - (delim_count + 1);
	suffix_string = "";
	while (suffix_count-->0) suffix_string = suffix_string "|";
	print $0 suffix_string;
}