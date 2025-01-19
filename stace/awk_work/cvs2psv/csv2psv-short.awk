BEGIN { FS = ","; OFS = "|"}

function print_field (field, sep) {
  gsub(/\"/,"",field)
  printf field sep
}

{
  quotes = "false"
  for (i=1; i<NF; i++) {
    gsub(/\%/,"%%", $i)
    if ($i ~ /.*"$/) { quotes = "false"; print_field($i,"|") } 
    else if ($i ~ /^".*/) { quotes = "true"; print_field($i,",") }
    else if (quotes == "true") { print_field($i,",") } 
    else { print_field($i,"|") }
  }
  gsub(/\"/,"",$i); print $NF "|"
}
