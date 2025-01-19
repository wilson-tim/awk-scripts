BEGIN {}

# Function to return ASCII value of character

function asc(char, l_found)
{
  for (i = 32; i < 127; i++){
    if (sprintf("%c", i) == char) l_found = i;
  }
  return l_found
}

{
  val = 111111;
  if ( length($1) == 0 ) { 
    print val 
  } else if ( length == 1 ) {
    val = (( asc(substr($1,1,1)) - 30) * 10000) + 1111
    print val 
  } else if ( length($1) == 2 ) {
    val = ( asc(substr($1,1,1)) - 30) * 10000
    val = val + (( asc(substr($1,2,1)) - 30) * 100) + 11
    print val 
  } else if ( length($1) == 3 ) {
    val = ( asc(substr($1,1,1)) - 30) * 10000
    val = val + (( asc(substr($1,2,1)) - 30) * 100)
    val = val + ( asc(substr($1,3,1)) - 30)
    print val 
  }
}

END {}
