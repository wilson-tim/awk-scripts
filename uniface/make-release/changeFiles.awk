# usage:
# gawk -f changeFiles.awk version="#VERSION#" type="#TYPE#" filename #TEMPLATE# #TARGET#
#
# #VERSION#  the release number
# #TYPE#     either test or live
# #TEMPLATE# is the filename used as a template to create the new file
# The template contains #ATTRIBUTE# markers which are replaced by those given by the user.
# #TARGET#   target filepath
#
# Eg.
# gawk -f changeFiles.awk version="releaseno" type="test" #VERSION#-#TYPE#-1-dir.vbs > C:\Swift_LG\Installation_Sets\v9113\Release\mss-update-only
#
BEGIN {}

{
  gsub(/#VERSION#/,version,$0)
  gsub(/#TYPE#/,type,$0)
  print $0
}

END {}
