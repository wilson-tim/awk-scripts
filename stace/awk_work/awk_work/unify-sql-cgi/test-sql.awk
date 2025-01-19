/q/ {
   system("rm *.tmp")
   exit }

/o/ {
   database("open","/u1/pharaoh/pharaoh_ds6/data.jsb") }
   
/c/ {
   database("close","/u1/pharaoh/pharaoh_ds6/data.jsb") }

/s/ {
   sql("xlock tn_dets where transaction_type = 'ST';","/u1/pharaoh/pharaoh_ds6/data.jsb/file.db")
   print_sql() }

