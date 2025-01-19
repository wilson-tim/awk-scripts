##############################################################
# Use like:
#
# awk -f U9_export.awk [The old file] > [The new file]
#
#############################################################

# Line separators CRLF
# BEGIN { RS="\r\n"; ORS="\r\n" }

BEGIN {}

# Ignore lines starting with !
/^!/{ print $0 ; next }
# Ignore lines starting with #
/^#/{ print $0 ; next }

# Replace curocc_video in lines containing it
/curocc_video/{ gsub(/curocc_video/,"curoccvideo") }
# Replace delete_instance in lines containing it
/delete_instance/{ gsub(/delete_instance/,"deleteinstance") }
# Replace field_syntax in lines containing it
/field_syntax/{ gsub(/field_syntax/,"fieldsyntax") }
# Replace field_video in lines containing it
/field_video/{ gsub(/field_video/,"fieldvideo") }
# Replace file_dump in lines containing it
/file_dump/{ gsub(/file_dump/,"filedump") }
# Replace file_load in lines containing it
/file_load/{ gsub(/file_load/,"fileload") }
# Replace idpart( in lines containing it
/idpart\(/{ gsub(/idpart\(/,"$idpart(") }
# Replace new_instance in lines containing it
/new_instance/{ gsub(/new_instance/,"newinstance") }
# Replace print_break in lines containing it
/print_break/{ gsub(/print_break/,"printbreak") }
# Replace $time in lines containing it
/\$time/{ gsub(/\$time/,"$clock") }
# Replace valuepart( in lines containing it
/valuepart\(/{ gsub(/valuepart\(/,"$valuepart(") }

# Print out all the lines whether changes have been made or not
{ print $0 }

END {}
