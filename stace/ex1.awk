BEGIN {}

NR > 5 && $4 != "<DIR>" {
	print $5 " " $4
}

END{}