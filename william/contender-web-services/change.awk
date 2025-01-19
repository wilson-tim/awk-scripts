# This will take one or more files as input and run the changes
# in the changes section on each file.
# 
# call like:
#
# awk -f changes.awk <file/s>
#
# eg. awk -f changes.awk *.jsp
#

BEGIN {
  file2 = "temp"
  firstfile = "true"
}

FNR==1 && firstfile=="false" {
  close(file2)
  cmd1 = "del " file1
  cmd2 = "ren " file2 " " file1
  system(cmd1)
  system(cmd2)

  file1 = FILENAME
}

FNR==1 && firstfile=="true" {
  file1 = FILENAME
  firstfile = "false"
}

# CHANGES SECTION START

/globe\.jpg/ {
  gsub(/globe\.jpg/,"image01.jpg")
}

/width="30" height="30"/ {
  gsub(/width="30" height="30"/,"height=\"30\"")
}

# CHANGES SECTION END

{print > file2}

END {
  close(file2)
  cmd1 = "del " file2
  system(cmd1)
}
