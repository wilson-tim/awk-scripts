BEGIN{ FS=","; OFS=","}
{
	if( $11 in usrn ){
		dup[$11] = dup[$11] "," NR
		print( $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," $8 "," $9 "," $10 "," $11 ) > "lbs_supersites_v2_dup.csv"
	}else{
		usrn[$11] = NR
		print( $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," $8 "," $9 "," $10 "," $11 ) > "lbss.out"
		
	}
}
END{
	for(item in dup){
		printf( usrn[item] ",") > "duplicate.out"
		print(item "," dup[item]) > "duplicate.out"
	}
}
