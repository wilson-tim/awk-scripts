BEGIN{ 	FS=","
	i=1
	while( (getline spec < "awkspecies01.csv") > 0 ){
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
	printf (NR ",") > "species.out"
	if ($1==0){
		printf (0) > "species.out"
	}else{
		for (j=1; j<i; j++){
			if( specData[j] == $1 ){
				printf (j) > "species.out"
			}
		}
	}
	printf ("," "EOL") > "species.out"
	print "" > "species.out"
	++rec
}

END{
	print "Total number of records: ", NF
	print "Total number of records loaded: ", rec

}



