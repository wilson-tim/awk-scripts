BEGIN {
	inputDone = "false"
	unique    = "false"
	uniqueDone= "false"
	printf("Enter filename: ")
}

{
	if(inputDone == "false" && unique == "false"){
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
		printf("Would you like to check values in other fields?"); getline
		$0 ~ /^([yY]|yes)$/ { unique = "true" }
	}

	if(inputDone == "true" && unique == "false"){
		rowNum = 1
		while( (getline < filename) > 0){
			if($column in org){
				print "Orginal:", $column, org[$column] > output
				print "Duplicate:", $column, rowNum > output
			}else{
				org[$column] = rowNum
			}
			++rowNum
		}
	}
	exit

	if(inputDone == "true" && unique == "true" && uniqueDone == "false"){
		printf("Please enter the column  numbers( n when done ):";getline

}

END {}
