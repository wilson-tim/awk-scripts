BEGIN {
  FS = ""
  flag = 0
}

{
  char = 1
  while (char <= NF) {
    if ($char == "<") {
      flag = 1;
      printf $char
    }
    else if ($char == ">") {
      flag = 0;
      printf $char
    }
    else if ($char == "_") {
      if (flag == 0) {
        printf $char
      }
      else {
        printf "U"
        printf "U"
      }
    }
    else if ($char == ".") {
      if (flag == 0) {
        printf $char
      }
      else {
        printf "D"
        printf "D"
      }
    }
    else {
      printf $char
    }
    char++
  }
}