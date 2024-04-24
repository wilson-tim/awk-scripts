# 240228  TW  New script to analyse dbt build log output

# $ awk -f new-dbt-full-refresh-errors.awk "new-dbt-full-refresh-errors.txt" | sort -t$'\t' -rns -k2,2 > "new-dbt-full-refresh-errors-analysis.txt

# Match lines that might have timing detail
/ [0-9]+ of [0-9]+ (OK|ERROR) / {

	# Remove control characters
	gsub(/\x1b\[0m/, "", $0);
	gsub(/\x1b\[31m/, "", $0);
	gsub(/\x1b\[32m/, "", $0);
	gsub(/\x1b/, "", $0);

	# Locate the timing detail
	startbracket=index($0, " in ");
	endbracket=index($0, "s]");
	start=startbracket+4;
	charcnt=endbracket-startbracket-4;

	# Extract the timing detail
	if (start>4 && charcnt>3)
	{
		a=substr($0, start, charcnt);
		b=int(a/60);
	}
	else
	{
		a="";
		b="";
	}

	# Output the timing detail
	print $0 "\t" a "\t" b;

}
