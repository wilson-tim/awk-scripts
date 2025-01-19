BEGIN{ 	FS=","
	i=1
	while( (getline spec < "awkclass01.csv") > 0 ){
		gsub( /[ ]+$/, "", spec )		
		specData[i] = spec
		print i " -> ", spec
		++i
	}
	print i
	print specData[1]
}

{

	#print "This is record ", NR, " :", $1
	printf (NR ",") > "speciesheight.out"
	if ($1==0){
		printf (0) > "speciesheight.out"
	}else{
		for (j=1; j<i; j++){
			if( specData[j] == $1 ){
				printf (j) > "speciesheight.out"
			}
		}
	}
	printf ("," "EOL") > "speciesheight.out"
	print "" > "speciesheight.out"
	++rec
}

END{
	print "Total number of records: ", NF
	print "Total number of records loaded: ", rec

}



