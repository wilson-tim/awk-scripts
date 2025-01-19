BEGIN { FS = "|"; OFS = "|" ; last[1] = ""; copy[1] = ""; result[1] = "" }

$0 != "" {

if ( $1 == last[1] )  # Same transaction so try copies
	{
	for ( i = 1; i <= NF; i++ )
		if ( $i != "" )  #  New data - set the copy
			{
			copy[i] = $i
			result[i] = $i
			}
		else
			result[i] = copy[i]  # Blank field try previous
	}
else                 # New transaction so reset copies
	{
	for ( i = 1; i <= NF; i++ )
		{
		copy[i] = $i
		result[i] = $i
		}
	}

for ( i = 1; i <= NF; i++ )
	{
	last[i] = $i
	if ( i != 1)
		printf("|")
	printf(result[i])
	}
printf("\n")
}

