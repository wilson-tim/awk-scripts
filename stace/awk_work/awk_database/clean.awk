# Run like
# awk -f forms.lib -f database.lib -f ph_hist.scr | awk -f clean.awk
#

{ 
   gsub(/\./,"_")
   print $0 }
