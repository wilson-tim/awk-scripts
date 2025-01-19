BEGIN{ 	FS=","
	i=1
	while( (getline spec < "species07.csv") > 0 ){
		gsub( /[ ]+$/, "", spec )		
		specData[i] = spec
		print i " -> ", spec
		++i
	}
	print i
	print specData[5]
}

{

	#print "This is record ", NR, " :", $1
	printf (NR ",") > "speciesabr.out"
	if (!$1){
		printf (0) > "speciesabr.out"
	}else{
		for (j=1; j<i; j++){
			if( j == $1 ){
				printf (specData[j]) > "speciesabr.out"
			}
		}
	}
	printf ("," "EOL") > "speciesabr.out"
	print "" > "speciesabr.out"
	++rec
}

END{
	print "Total number of records: ", NF
	print "Total number of records loaded: ", rec

}



