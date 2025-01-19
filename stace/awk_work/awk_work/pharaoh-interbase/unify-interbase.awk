BEGIN {
   skip_vol = "false" 
   skip_con = "false" }


$1 ~ /description/ || $1 ~ /display/ && skip_con == "true"  {
   skip_con = "false"
   next }

/^commit work/ && skip_vol == "true" {
   skip_vol = "false"
   next }

skip_vol == "true" || skip_con == "true" { next }

/^--/ { next }

/^set current/ { next }

/^create volume/ {
   skip_vol = "true"
   next }

/configuration.*);$/ { next }

/configuration/ {
   skip_con = "true"
   next }

{ print }


END {}
