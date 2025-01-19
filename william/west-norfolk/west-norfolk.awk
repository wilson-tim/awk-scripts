BEGIN {
  FS="|"; OFS="|"
}

{
  # Remove fullstops from Company Name
  gsub(/\./,"",$1)

  # Remove fullstops and brakets from Customer Contact
  gsub(/\./,"",$2)
  gsub(/\(/,"",$2)
  gsub(/\)/,"",$2)

  # Remove brackets and add space after 5th digit from Customer Telephone Number  
  gsub(/\(/,"",$3)
  gsub(/\)/,"",$3)
  if(length($3) > 6) {
    tel_head=""; tel_tail=""
    tel_head=substr($3,1,5)
    tel_tail=substr($3,6)
    $3=tel_head " " tel_tail
  }
  gsub(/ +/," ",$3)

  # Remove brackets and add space after 5th digit from Branch Telephone Number  
  gsub(/\(/,"",$4)
  gsub(/\)/,"",$4)
  if(length($4) > 6) {
    tel_head=""; tel_tail=""
    tel_head=substr($4,1,5)
    tel_tail=substr($4,6)
    $4=tel_head " " tel_tail
  }
  gsub(/ +/," ",$4)

  # Print the updated line
  print $0
}

END {}

