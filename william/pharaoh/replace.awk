# called like:
#
# awk -f start=<num> end=<num> replace.awk
#

BEGIN {}

NR >= start && NR <= end && /jsp:param.*value=""/ {
  field_name = substr($2,7,length($2) - 7)
  field_value = "\"<%= " field_name " %>\""
  sub(/""/,field_value)
  print $0
  next
}
  
{
  print $0
}
