###############################################################################
#                                                                             #
# lambda script VERSION 1b                                                    #
# (c) William Wragg/Datapro Software Ltd. 2000                                #
# BY WILLIAM WRAGG                                                            #
# DATE 02/10/2000                                                             #
#                                                                             #
# Notes:                                                                      #
#  Call with:                                                                 #
#                                                                             #
# All local variables are preceded with an underscore e.g. _local             #
#                                                                             #
# Local variables are declared as extra parameters in the parameter list of   #
# function definitions. The convention is to separate local variables from    #
# real parameters by extra spaces in the parameter list. But I use an         #
# underscore in front of the names of all local variables.                    #
#                                                                             #
###############################################################################

BEGIN {
  x = 9
  y = 10
  print lambda("{x, y} {return x + y}", "16 , 3")
}


# FUNCTION SECTION.
# -----------------
# This is a lambda function definition
function lambda(lambda_func, args, _lambda, _vars, _body, _call, _cmd, _file) {
  _file = "lambda.tmp"
  
  # Find the vars
  match(lambda_func, /}/)
  _vars = substr(lambda_func, 1, RSTART)
  gsub(/[{}]/,"",_vars)
  
  # Find the body
  _body = substr(lambda_func, RSTART + 1)
  gsub(/^[ \t]*{/,"",_body)
  gsub(/[ \t]*}$/,"",_body)

  # Create the lambda function
  _lambda = "function _(" _vars "){\n" _body "\n}\n\n"
  # Replace " with \"
  gsub(/"/,"\\\"",_lambda)
  
  # Call the function
  _call = "BEGIN {\n  print _(" args ")\n}"
  # Replace " with \"
  gsub(/"/,"\\\"",_lambda)
  
  print _lambda _call > _file
  close(_file)
  _cmd = "awk -f " _file
  _cmd | getline _return
  close(cmd)
  return _return
}
# ------------------------
# END OF FUNCTION SECTION.


# PATTERN SECTION.
# ----------------

# -----------------------
# END OF PATTERN SECTION.


END {}
