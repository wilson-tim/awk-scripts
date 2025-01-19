BEGIN {}


{  
   print column_no("fx_dets", "account_code")
   print "Starting find ..."
#   find("ph_hist", "CLE", "contract_type")
#   find("fx_dets", "HOC045-552395", "account_code")
   total("ph_hist")
   print "Finished find." }   


END {}
