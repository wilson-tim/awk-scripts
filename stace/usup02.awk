BEGIN{ FS=","
       OFS=","}

{
	if($1&&(!$2)){print($1 "S") > "usup.out"}
		else{ print($2) > "usup.out"}
}
