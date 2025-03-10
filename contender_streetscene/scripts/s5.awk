BEGIN { FS = "|"
	print "<?xml version=\"1.0\" ?>"
	print "<eShopContenderIntegration>"
	fName[1]="createdDate"
	fName[2]="processedDate"
	fName[3]="complaintId"
	fName[4]="eShopIncidentid"
	fName[5]="UPRN"
	fName[6]="dateRaised"
	fName[7]="rectifyDate"
	fName[8]="service"
	fName[9]="faultCode"
	fName[10]="description"
	fName[11]="statusDescription"
	fName[12]="customerId"
	fName[13]="eShopCustomerId"
	fName[14]="firstName"
	fName[15]="lastName"
	fName[16]="customerUPRN"
	fName[17]="address1"
	fName[18]="address2"
	fName[19]="address3"
	fName[20]="address4"
	fName[21]="address5"
	fName[22]="city"
	fName[23]="postCode"
	fName[24]="telephone"
	fName[25]="email"
	fName[26]="importStatus"
	fName[27]="importStatusDescription"
	fName[28]="complaintId"
	fName[29]="eShopIncidentid"
	fName[30]="UPRN"
	fName[31]="dateRaised"
	fName[32]="rectifyDate"
	fName[33]="service"
	fName[34]="faultCode"
	fName[35]="description"
	fName[36]="statusDescription"
	fName[37]="importStatus"
	fName[38]="importStatusDescription"
	fName[39]="customerId"
	fName[40]="eShopCustomerId"
	fName[41]="firstName"
	fName[42]="lastName"
	fName[43]="customerUPRN"
	fName[44]="address1"
	fName[45]="address2"
	fName[46]="address3"
	fName[47]="address4"
	fName[48]="address5"
	fName[49]="city"
	fName[50]="postCode"
	fName[51]="telephone"
	fName[52]="email"

        init = 1
	}

{
	check_illegal()
	if ( init == 1) {
	    printf("  <%s>%s</%s>\n", fName[1], $1, fName[1]) 
	    printf("  <%s>%s</%s>\n", fName[2], $2, fName[2]) 
            print "  <eShopIn>"
	    print "    <complaintRecords>"
	    init = 0 
	    }
	    print "      <complaint>"
	    for (i = 3; i <=11; i++){
		    printf("        <%s>%s</%s>\n", fName[i], $i, fName[i]) }
	    print "        <customers>"
	    print "          <customer>"
	    for (i = 12; i <=25; i++){
		    printf("          <%s>%s</%s>\n", fName[i], $i, fName[i]) }
	    print "          </customer>"
	    print "        </customers>"
	    print "      </complaint>"
}

END 	{   
	    print "    </complaintRecords>"
            print "  </eShopIn>"
            print "</eShopContenderIntegration>"
}

function check_illegal()
{
   gsub("&", "&amp;")
   gsub("<", "&lt;")
   gsub(">", "&gt;")
   gsub("'", "&apos;")
   gsub("\"", "&quot;")
}

 