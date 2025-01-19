BEGIN{ FS=","; OFS=","}
{
	if( $1 in usrn ){
		dup[$1] = dup[$1] "," NR
		print usrn[$1], NR, $1 > "greenduplicates.csv"
	}else{
		usrn[$1] = NR
		print $1, $2 > "domestic_recycling_v1.csv"
	}
}
END{
}
