
echo "Getting the information..."

awk '/RECORDS DUMPED/{print $4,$7}' $1 > $PHABASE/tmp/sub1.tmp
awk '/create table/{Table = $3}
     /estimated count/{gsub(/,/,"",$4)
                       print Table,$4}' $2 > $PHABASE/tmp/schema1.tmp

echo "Sorting the files..."

sort -d $PHABASE/tmp/sub1.tmp > $PHABASE/tmp/sub2.tmp
sort -d $PHABASE/tmp/schema1.tmp > $PHABASE/tmp/schema2.tmp

echo "Doing the compare..."

awk '
BEGIN { 
   Found = "false"
}

{
   Table = $1; Size = $2
   File = ENVIRON["PHABASE"] "/tmp/schema2.tmp"
   while ( ( getline < File) > 0 ) {
      split($0,Schema)
      if (Table == Schema[1]) {
         if (Size >= Schema[2]) {
            if (Found == "false") {
               print "Table/s which need attention..."
               print Table,Size
               Found = "true"
               break
            }
            else {
               print Table,Size
               break
            }
         }
      }
   }
   close(File)
}

END {
   if (Found == "false") {print "Schema OK."}
}' $PHABASE/tmp/sub2.tmp

rm $PHABASE/tmp/sub1.tmp
rm $PHABASE/tmp/sub2.tmp
rm $PHABASE/tmp/schema1.tmp
rm $PHABASE/tmp/schema2.tmp
