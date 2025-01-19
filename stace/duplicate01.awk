BEGIN {
	inputDone = "false"
	printf("Enter filename: ")
}

{
	if(inputDone == "false"){
		filename = $0;
		printf("Enter column number: "); getline
		column = $0;
		printf("Enter FS: "); getline
		FS = $0;
		printf("Enter OFS: "); getline
		OFS = $0;
		printf("Enter output file:"); getline
		output = $0
		inputDone = "true"
	}

	if(inputDone == "true"){
		rowNum = 1
		while( (getline < filename) > 0){
			if($column in org){
				print "Org:", $column, org[$column] > output
				print "Dup:", $column, rowNum > output
			}else{
				org[$column] = rowNum
			}
			++rowNum
		}
	}
	exit
}

END {}
