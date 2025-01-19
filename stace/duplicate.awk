BEGIN{ FS=","}
{
	if( $1 in usrn ){
		dup[$1] = dup[$1] "," NR
	}else{
		usrn[$1] = NR
	}
}
END{
	for(item in dup){
		printf( usrn[item] ",") > "duplicate.out"
		print(item "," dup[item]) > "duplicate.out"
	}
}
