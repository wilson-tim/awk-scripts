BEGIN { FS="|" }

{  
   order = 1; total = 30
   while (order <= total) {
      count = 1
      while (count <= $NF) {
         if ($count == order) { 
            if (order == total) { printf count ; break }
            else { printf count "|" ; break }
         }
         count++
      }
      order++
   }
}
