# FOR UNIX SYSTEMS ONLY:
# Note the use of "\r" during raw mode.  Newlines will not be translated
# into \n\r sequences,  so you have to do that yourself.
# 
# "stty -g" captures the current stty settings in a numerical symbolic
# format that can be used to restore the original settings.  This is
# a better method than "stty cooked" or "stty sane".
# 
# Note also that the arg list in the function definition is longer than
# the arg list when the function is called.  This creates automatic
# variables whose scope is limited to the function.  It is traditional
# to separate "automatic" variables from called parameters by a
# double space.
# 
# Obviously,  the faster the hardware,  the better this works.
# 
# example:
# ans = prompt("Enter Yes[y] or No[n] == > ","^[nyNY]$")
# printf "\nans = %s\n", ans

function prompt(msg, goodchars,  stty, dd, ans, cooked) {
stty = "stty -g"
stty | getline cooked
close(stty)
system("stty raw")
dd = "dd bs=1 count=1 2>/dev/null"
# I'd just suggest using command "dd cbs=1 count=1 conv=unblock 2>/dev/null"
# instead, so that the output has two bytes, the second being "\n".
# I'm afraid that awk may feel unhapy when the last record is not terminated
# by a newline.

printf "%s", msg
do {
   if (ans) {
      printf "\r\nInvalid Response '%s'\r\n", ans
      printf "%s", msg
      }
   dd | getline ans
   close(dd)
   } while (ans !~ goodchars)

system("stty " cooked)
return(ans)
}
