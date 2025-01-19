BEGIN { FS = "|"
	print "<?xml version=\"1.0\" ?>"
	print "<avGISIntegration>"
	fName[1]="complaintNo"
	fName[2]="dateEntered"
	fName[3]="siteRef"
	fName[4]="location"
	fName[5]="easting"
	fName[6]="northing"
	fName[7]="carId"
	fName[8]="make"
	fName[9]="model"
	fName[10]="colour"
	fName[11]="actionFlag"
	fName[12]="officerId"

        init = 1
	}

{
	check_illegal()
	if ( init == 1) {
            print "  <avExports>"
	    print "    <complaintRecords>"
	    init = 0 
	    }
	    print "      <complaint>"
	    for (i = 1; i <=12; i++){
		    printf("        <%s>%s</%s>\n", fName[i], $i, fName[i]) }
	    print "      </complaint>"
}

END 	{   
	    print "    </complaintRecords>"
            print "  </avExports>"
            print "</avGISIntegration>"
}

function check_illegal()
{
   gsub("&", "&amp;")
   gsub("<", "&lt;")
   gsub(">", "&gt;")
   gsub("'", "&apos;")
   gsub("\"", "&quot;")
}

