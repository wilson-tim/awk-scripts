BEGIN {FS="|"; OFS="|"; first_record=true; counter=1; old_menu_name=""}

{if(first_record) {first_record=false}
 else if(old_menu_name != $1) {counter=1}}

{print $1,$2,counter,$4,$5
 counter++
 old_menu_name=$1}
